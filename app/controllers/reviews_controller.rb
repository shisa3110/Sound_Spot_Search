class ReviewsController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id]) 
    @review = @spot.reviews.build(review_params) 
    if @review.save
      redirect_to spot_path(reviews.spot), success: "口コミを投稿しました"
    else
      redirect_to spot_path(@review.spot), danger: "口コミを投稿できませんでした"
    end
  end
  
  private

  def review_params
    params.require(:review).permit(:body).merge(spot_id: params[:spot_id])
  end
end