class BookmarksController < ApplicationController
  def create
    # Spotモデルからspot_idを探す。
    @spot = Spot.find(params[:spot_id])
    # ログイン中のユーザーと紐づいたspot_idから、Userモデルのbookmarkメソッドを実行する。
    current_user.bookmark(@spot)
  end

  def destroy
    # ユーザーのブックマークからidを探す。idに紐づくスポット情報を取得する。
    @spot = current_user.bookmarks.find(params[:id]).spot
    # ログイン中のユーザーと紐づいたidから、Userモデルのunbookmarkメソッドを実行する。
    current_user.unbookmark(@spot)
  end
end
