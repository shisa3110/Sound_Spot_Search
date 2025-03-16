class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @spot = Spot.find(params[:spot_id]) 
    @review = @spot.reviews.build(review_params) 
    if @review.save
      flash[:success] = "口コミを投稿しました"
      redirect_to spot_path(@review.spot)
    else
      flash.now[:danger] = "口コミを投稿できませんでした"
      redirect_to spot_path(@review.spot)
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy!
    flash[:success] = "口コミが削除されました"
    redirect_to spot_path(@review.spot)
  end

  private

  def review_params
    params.require(:review).permit(:body).merge(user_id: current_user.id)
  end
end