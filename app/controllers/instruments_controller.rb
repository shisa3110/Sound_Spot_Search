class InstrumentsController < ApplicationController
  def index
    @Instruments = Instrument.includes(:user)
  end
end
