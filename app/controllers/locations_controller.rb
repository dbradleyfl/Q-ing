class LocationsController < ApplicationController

  def create
    location = Location.create(location_params)
    session[:category] = location.category
    if location.save
      render :json => location
    else
      render :json => "false"
    end
  end

  def update_geo
    @location = Location.find(location_params[:id])

    if @location.update(location_params)
      p @location
      render :json => true
    else
      render :json => false
    end
  end

  def load_pins
    if session[:category] == nil
      @locations = Location.all
    else
      @locations = Location.where(category: session[:category])
    end
    p session[:category]
    render :json => @locations
  end

  def update_categories
    session[:category] = params["Places"]
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :name, :longitude, :category, :id)
  end

end

