require 'rails_helper'

describe Duration do 
	it "is valid with a duration, location_id, and user_id" do
		expect(FactoryGirl.build(:duration)).to be_valid
	end

	it "is invalid without a duration" do
		expect(FactoryGirl.build(:duration, duration: nil)).not_to be_valid
	end

	it "is invalid without a location_id" do
		expect(FactoryGirl.build(:duration, location_id: nil)).not_to be_valid
	end

	it "is invalid without a user_id" do
		expect(FactoryGirl.build(:duration, user_id: nil)).not_to be_valid
	end
end