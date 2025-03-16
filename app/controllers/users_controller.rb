class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def my_reviews
    @my_reviews = current_user.reviews.includes(:spot).page(params[:page]).per(4)
  end

  def my_instruments
    @my_instruments = current_user.instruments.includes(:user).page(params[:page]).per(6)
  end
end
