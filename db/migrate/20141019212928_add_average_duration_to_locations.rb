class AddAverageDurationToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :average_duration, :integer
  end
end
