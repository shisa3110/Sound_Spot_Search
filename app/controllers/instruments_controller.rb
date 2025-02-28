class InstrumentsController < ApplicationController
  def index
    @Instruments = Instrument.includes(:user)
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

  private
  def instrument_params
    params.require(:instrument).permit(:title, :comment, :image, :kind)
  end

end
