class SpotsController < ApplicationController
  def map
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end
end