class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.references :location
      t.references :user

      t.timestamps
    end
  end
end
