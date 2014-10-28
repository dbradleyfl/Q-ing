class AddDefaultValueAveragesToLocations < ActiveRecord::Migration
  def change
  	change_column :locations, :average_duration, :integer, :default => 0
  end
  
end
