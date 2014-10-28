require 'rails_helper'

describe Location do

	it "is valid with a latitude, longitude, name, and category" do
		expect(FactoryGirl.build(:location)).to be_valid
	end

	it "is invalid without a name and category" do
		expect(FactoryGirl.build(:location, name: nil, category:nil )).not_to be_valid
	end
end
