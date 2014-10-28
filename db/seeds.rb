Location.create(latitude: 37.789543, longitude: -122.395036, name: "Town Hall", category: "restaurant", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.791612, longitude: -122.394993, name: "Bistro Burger", category: "restaurant", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.792337, longitude: -122.393067, name: "Rincon Grill", category: "restaurant", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.793914, longitude: -122.399161, name: "McDonald\'s", category: "bathroom", latest_duration: 30, average_duration: 35)

Location.create(latitude: 37.790506, longitude: -122.389140, name: "Waterbar", category: "restaurant", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.794846, longitude: -122.399526, name: "One Embarcado Center", category: "theater", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.794851, longitude: -122.399456, name: "One Embarcado Center", category: "bathroom", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.794631, longitude: -122.394918, name: "Dundas Little Theatre", category: "theater", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.787466, longitude: -122.398824, name: "Osha Thai Restaurant", category: "restaurant", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.787462, longitude: -122.398899, name: "Osha Thai Restaurant", category: "bathroom", latest_duration: rand(5..30), average_duration: rand(5..30))

Location.create(latitude: 37.762865, longitude: -122.432186, name: "Frances", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.762401, longitude: -122.397071, name: "Chez Maman", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.800732, longitude: -122.407929, name: "Don Pisto\’s", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.767197, longitude: -122.428593, name: "Chow", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.796903, longitude: -122.402960, name: "BIX", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.759383, longitude: -122.465996, name: "Nopalito", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.790883, longitude: -122.420217, name: "Cordon Bleu Vietnamese", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.793320, longitude: -122.392761, name: "Boulevard", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.789808, longitude: -122.391039, name: "Prospect", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.808673, longitude: -122.409821, name: "Fog Harbor Fish House", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.793682, longitude: -122.399179, name: "Barbacco", category: "restaurant", latest_duration: rand(5..50), average_duration: rand(5..30))

Location.create(latitude: 37.779246, longitude: -122.414571, name: "Orpheum Theatre", category: "theater", latest_duration: rand(5..50), average_duration: rand(5..30))





#Seeding Database wiht Users
5.times do
  User.create(
  username: Faker::Name.first_name.downcase,
  password_digest:"12345",
  email: Faker::Internet.email)
end

#Generate New Locations Within SF Area
# 100.times do
# 	lat = (37.665 + rand()/10)
# 	lon = (-122.4 - rand()/10)
# 	category = ["bathroom", "restaurant", "theater"].sample
# 	Location.create(latitude: lat, longitude: lon, name: Faker::Name.first_name, category: category, latest_duration: rand(5..30), average_duration: rand(5..30))

# end


#Assign durations to locations
Location.all.each do |location|
	20.times do 
	location.durations.create(
		duration: rand(5..60),
		user_id: rand(1..5),
		)
  end

end


