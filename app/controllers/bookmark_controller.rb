class BookmarkController < ApplicationController
  def create
    # Spotモデルからspot_idを探す。
    @spot = Spot.find(params[:spot_id])
    # ログイン中のユーザーと紐づけられたidを取得し、userモデルの定義を使用してid情報を保存する。
    current_user.bookmark(@spot)   
  end

  def destoy
    @spot = current_user.bookmarks.find(params[:spot_id]).spot
    current_user.unbookmark(@spot)
  end
end
