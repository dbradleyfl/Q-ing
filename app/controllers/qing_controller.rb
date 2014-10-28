class QingController < ApplicationController

  def index
  	locations = Location.all
  	locations.each do |location|
  		location.update_averages
  	end
  end

end
