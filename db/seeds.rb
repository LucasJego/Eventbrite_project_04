# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#require 'faker'

puts 'Suppression des événements'
Event.destroy_all
puts 'Suppression des utilisateurs'
User.destroy_all
puts 'Suppression des participations aux événements'
Attendance.destroy_all

users_array = []
events_array = []


puts "\n\nCréation des utilisateurs"
10.times do
	user = User.new(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: "#{Faker::Name.first_name}@yopmail.com",
		description: Faker::Lorem.sentence(word_count: 20),
		encrypted_password: 'abcdefgh'
		)
	user.save
	users_array << user
	puts "#{user.first_name} #{user.last_name} a été créé"
	puts user.email
end
puts "\n10 utilisateurs ont été créés."


puts "\n\nCréation des événements"
10.times do 
	event = Event.new(
		start_date: Faker::Date.forward(days: 30),
		duration: 45, title: Faker::Book.title,
		description: Faker::Lorem.sentence(word_count: 40),
		price: rand(1..1000), location: Faker::Address.city,
		administrator: users_array.sample
		)
	event.save
	events_array << event
	puts "L'événement #{event.title} a été créé."
end
puts "\n10 événements ont été créés."
	


# Les participations sont créées en dernier car on a besoin d'un événement et d'un utilisateur pour les créer.
puts "\n\nCréation des participations"
5.times do
	attendance = Attendance.new(
		administrator: users_array.sample,
		attendant: users_array.sample,
		event: events_array.sample
		)
	attendance.save
	puts "La participation à l'événement #{attendance.event.title} a été créée."
end
puts '5 participations ont été créées.'


