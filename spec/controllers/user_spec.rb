require 'rails_helper'

RSpec.describe UsersController, :type => :controller do


	describe "POST #create" do
		context "with valid attributes" do
			it "saves the new user in the database" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user)
				}.to change(User, :count).by(1)
			end
		end
	end
end