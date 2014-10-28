class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :lattitude, scale: 5
      t.string :longitude, scale: 5
      t.string :name
      t.string :category


      t.timestamps
    end
  end
end
