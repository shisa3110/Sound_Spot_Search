class LikesController < ApplicationController
  def create
    @instrument = Instrument.find(params[:instrument_id])
    current_user.like(@instrument)
  end

  def destroy
    @instrument = current_user.likes.find(params[:id]).instrument
    current_user.unlike(@instrument)
  end
end
