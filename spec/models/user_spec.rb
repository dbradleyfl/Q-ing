require 'rails_helper'

describe User do 
	it "is valid with a username, and password" do
		expect(FactoryGirl.build(:user)).to be_valid
	end

	it "is invalid without a username" do
		user = FactoryGirl.build(:user, username: nil)
		expect(user).not_to be_valid
	end

	it "is invalid without a password" do 
		expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
	end

	it "is invalid without a unique password" do 
		User.create(username: "yentizzle", password: "inolikewaittimes")
		user = User.create(username: "yentizzle", password: "iloveq_ing")
		expect(user).not_to be_valid
	end

	it "fails because password confirmation doesn't match" do
		user = User.new(username: "yentizzle", password: 'inolikewaittimes', password_confirmation: 'aa')
		expect(user).not_to be_valid
	end

	it "succeeds because password & confirmation match" do
		user = User.new(username: "yentizzle", password: 'inolikewaittimes', password_confirmation: 'inolikewaittimes')
		expect(user).to be_valid
	end
end