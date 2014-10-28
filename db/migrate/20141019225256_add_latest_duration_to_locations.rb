class AddLatestDurationToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :latest_duration, :integer
  end
end
