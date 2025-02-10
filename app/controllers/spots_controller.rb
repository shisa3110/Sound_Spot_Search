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
    if @spot.save
      redirect_to root_path
    else
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
    if @spot.update(spot_params)
      redirect_to spot_path(@spot)
    else
      flash[:alert] = "更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    spot = Spot.find(params[:id])
    spot.destroy!
    redirect_to spots_map_path, success: "削除に成功しました。"
  end

  private
  def spot_params
    params.require(:spot).permit(:name, :postal_code, :address, :phone_number, :web_site, :latitude, :longitude, :opening_hours)
  end
end
