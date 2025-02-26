class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @spot = Spot.find(params[:spot_id]) 
    @review = @spot.reviews.build(review_params) 
    if @review.save
      redirect_to spot_path(@review.spot), success: "口コミを投稿しました"
    else
      redirect_to spot_path(@review.spot), danger: "口コミを投稿できませんでした"
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy!
    redirect_to spot_path(@review.spot), notice: '口コミが削除されました'
  end

  private

  def review_params
    params.require(:review).permit(:body).merge(user_id: current_user.id)
  end
end