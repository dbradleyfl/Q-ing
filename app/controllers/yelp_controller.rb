class YelpController < ApplicationController
  
  def coords
    coordinates = {latitude: yelp_params[:latitude], longitude: yelp_params[:longitude]}
    params = { term: 'restaurant', limit: 5, sort: 1 }
    results = Yelp.client.search_by_coordinates(coordinates, params)
    render :json => results
  end

  private

  def yelp_params
    params.require(:yelp).permit(:latitude, :longitude)
  end

end
