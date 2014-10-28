class Duration < ActiveRecord::Base
	belongs_to :location
	belongs_to :user

	validates_presence_of :duration, :location_id, :user_id
end
