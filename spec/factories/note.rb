FactoryGirl.define do 
	factory :notes do
		note Faker::Lorem.sentence(3)
		location_id	1
	end
end