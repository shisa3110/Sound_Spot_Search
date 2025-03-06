class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :create, :new, :destroy ]
  helper_method :prepare_meta_tags

  def map
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end

  def index
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save_with_tags(tag_names: params.dig(:spot, :tag_names).split(",").uniq)
      redirect_to spot_path(@spot), success: "施設情報を作成しました"
    else
      flash.now[:danger] = "施設情報を作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @review = Review.new
    @reviews = @spot.reviews.includes(:user).order(created_at: :desc)
    prepare_meta_tags(@post)
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
    if @spot.save_with_tags(tag_names: params.dig(:spot, :tag_names).to_s.split(",").uniq)
       redirect_to spot_path(@spot), success: "施設情報を作成しました"
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

  def autocomplete
    @q = Spot.ransack(name_cont: params[:q])
    @spots = @q.result(distinct: true).limit(10)

    render json: @spots.as_json(only: [ :name ])
  end

  private
  def spot_params
    params.require(:spot).permit(:name, :spot_image, :category, :postal_code, :address, :phone_number, :web_site, :latitude, :longitude, :opening_hours)
  end

  def prepare_meta_tags(spot)
        image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(Spot.name)}"
        set_meta_tags og: {
                        site_name: 'Sound Spot Search',
                        title: Spot.name,
                        description: '楽器の練習等大きな音を鳴らすことのできる場所を地図や一覧から検索するサービスです。',
                        type: 'website',
                        url: request.original_url,
                        image: images_ogp_url('ogp.png'),
                        locale: 'ja-JP'
                      },
                      twitter: {
                        card: 'summary_large_image',
                        site: '@https://x.com/ss_runteq55b',
                        image: images_ogp_url('ogp.png')
                      }
  end
end
