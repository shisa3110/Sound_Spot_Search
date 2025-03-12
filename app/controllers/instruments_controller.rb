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
      redirect_to instruments_path, success: "my楽器投稿に成功しました"
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
      redirect_to instruments_path, success: "投稿の編集に成功しました"
    else
      flash.now[:danger] = "編集の保存に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instrument = Instrument.find(params[:id])
    @instrument.destroy!
    redirect_to instruments_path, success: "削除に成功しました。"
  end

  def likes
    @like_instruments = Instrument.where(id: current_user.likes.pluck(:instrument_id)).page(params[:page]).per(6)
  end

  private
  def instrument_params
    params.require(:instrument).permit(:title, :comment, :instrument_image, :kind)
  end

end
