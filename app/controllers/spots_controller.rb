class SpotsController < ApplicationController
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

  private
  def spot_params
    params.require(:spot).permit(:name, :post_code, :address, :phone_number, :web_site, :latitude, :longitude, :opening_hours)
  end
end
