class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @works = @location.works.page(params[:page]).per_page(40)
  end

end
