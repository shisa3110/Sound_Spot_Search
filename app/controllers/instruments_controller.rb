class InstrumentsController < ApplicationController
  def index
    @instruments = Instrument.order(:created_at).page(params[:page]).per(6)
  end

  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = current_user.instruments.build(instrument_params)
    if @instrument.save
      flash[:success] = "my楽器を投稿しました" 
      redirect_to instruments_path
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @instrument = current_user.instruments.find(params[:id])
  end

  def update
    @instrument = current_user.instruments.find(params[:id])
    if @instrument.update(instrument_params)
      flash[:success] = "投稿を編集しました" 
      redirect_to instruments_pathx
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy!
    flash[:success] = "投稿を削除しました" 
    redirect_to instruments_path
  end

  def likes
    @like_instruments = Instrument.where(id: current_user.likes.pluck(:instrument_id)).page(params[:page]).per(6)
  end

  private
  def instrument_params
    params.require(:instrument).permit(:title, :comment, :instrument_image, :kind)
  end

end
