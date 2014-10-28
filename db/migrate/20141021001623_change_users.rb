class ChangeUsers < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, :unique => true, :null => false
    change_column :users, :password_digest, :string, :null => false
  end
end

