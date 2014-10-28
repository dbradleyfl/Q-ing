class AddDefaultValueZeroLastDurationToLocations < ActiveRecord::Migration
  def change
  	  	change_column :locations, :latest_duration, :integer, :default => 0
  end
end
