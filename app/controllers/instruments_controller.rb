class InstrumentsController < ApplicationController
  def index
    @Instruments = Instrument.includes(:user)
  end

  def new
    @instrument = Instrument.new
  end
end
