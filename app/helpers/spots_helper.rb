module SpotsHelper
  # 施設詳細情報の施設公式ウェブサイトリンクのセキュリティ対策
  def valid_url?(url)
    # 与えられた文字列をURL形式に変換
    uri = URI.parse(url)
    # HTTPまたはHTTPSであるか確認
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end