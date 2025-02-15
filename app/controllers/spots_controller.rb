class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :create, :new, :destroy]

  def map
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save_with_tags(tag_names: params.dig(:spot, :tag_names).split(',').uniq)
      redirect_to spot_path(@spot), success: '施設情報を作成しました'
    else
      flash.now[:danger] = '施設情報を作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def bookmarks
    @bookmark_spots = current_user.bookmarks.includes(:user).map(&:spot)
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.assign_attributes(spot_params)
    if @spot.save_with_tags(tag_names: params.dig(:spot, :tag_names).to_s.split(',').uniq)
       redirect_to spot_path(@spot), success: '施設情報を作成しました'
    else
      flash[:alert] = "更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy!
    redirect_to spots_map_path, success: "削除に成功しました。"
  end

  private
  def spot_params
    params.require(:spot).permit(:name, :category, :postal_code, :address, :phone_number, :web_site, :latitude, :longitude, :opening_hours)
  end
end
