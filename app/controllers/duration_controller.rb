class DurationController < ApplicationController
  def new

  end

  def create
  	duration = Duration.create(duration_params)
    duration.location.update_averages
  	success_status = duration.save
    location = duration.location
  	render :json => location
  end

  private

  def duration_params
    p "inside strong params"
    params.require(:duration).permit(:duration, :location_id, :user_id)
  end
end

