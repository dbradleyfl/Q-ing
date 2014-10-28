class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
   	  t.integer :duration
      t.references :location
      t.references :user

      t.timestamps
    end
  end
end
