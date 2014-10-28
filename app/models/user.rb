class User < ActiveRecord::Base
	has_secure_password
	has_many :durations
	validates_presence_of :password, :on => :create
	validates_presence_of :username, :on => :create
	validates_uniqueness_of :username, :on => :create	
end
  