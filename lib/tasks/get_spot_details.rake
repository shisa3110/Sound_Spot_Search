require "csv" # csvファイルを操作するライブラリの読み込み
require "open-uri" # open-uriライブラリを読み込んでいる
require "json" # jsonライブラリを読み込む
API_KEY = ENV["GOOGLE_PLACES_API_KEY"] # .envに記述しているAPIキーを代入

namespace :get_spot_details do
  desc "Fetch and save shop details"
  task get_and_save_details: :environment do
    # 電話番号からplace_idを取得するメソッド
    def get_place_id(name)
      client = GooglePlaces::Client.new(API_KEY)
      spot = client.spots_by_query(name).first
      spot.place_id if spot
    end

    # place_idから詳細情報を取得するメソッド
    def get_detail_data(spot)
      place_id = get_place_id(spot["施設名"])

      if place_id
        # DB内を探し、既に保存されている場合はスキップ
        existing_spot = Spot.find_by(place_id: place_id)
        if existing_spot
          puts "既に保存済みです: #{spot['スポット名']}"
          return nil
        end

        # クエリパラメータの作成
        place_detail_query = URI.encode_www_form(
        place_id: place_id,
        language: "ja",
        key: API_KEY
        )
        # PlacesAPIのエンドポイントの作成
        place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
        # APIから取得したデータをテキストデータ（JSON形式）で取得し、変数に格納
        place_detail_page = URI.open(place_detail_url).read
        # JSON形式のデータを、Rubyオブジェクトに変換
        place_detail_data = JSON.parse(place_detail_page)

        # 取得したデータを保存するカラム名と同じキー名で、ハッシュ（result）に保存
        result = {}
        result[:name] = place_detail_data["result"]["name"]
        result[:postal_code] = place_detail_data["result"]["address_components"].find { |c| c["types"].include?("postal_code") }&.fetch("long_name", nil)

        full_address = place_detail_data["result"]["formatted_address"]
        result[:address] = full_address.sub(/\A[^ ]+/, "")

        result[:phone_number] = place_detail_data["result"]["formatted_phone_number"]
        result[:opening_hours] = place_detail_data["result"]["opening_hours"]["weekday_text"].join("\n") if place_detail_data["result"]["opening_hours"].present?
        result[:web_site] = place_detail_data["result"]["website"]
        result[:latitude] = place_detail_data["result"]["geometry"]["location"]["lat"]
        result[:longitude] = place_detail_data["result"]["geometry"]["location"]["lng"]
        result[:place_id] = place_id

        result
      else
        puts "詳細情報が見つかりませんでした。"
        nil
      end
    end

    # csvファイルを読み込む
    csv_file = "lib/tasks/spot.csv"
    # csvファイルの繰り返し処理で実行しデータベースへ保存
    CSV.foreach(csv_file, headers: true) do |row|
      spot_data = get_detail_data(row)
      if spot_data
        spot = Spot.create!(spot_data)
        puts "Spotを保存しました: #{row['スポット名']}"
        puts "----------"
      else
        puts "#{row['スポット名']}の保存に失敗しました"
      end
    end
  end
end
