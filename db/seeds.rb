# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "clearing the field's 🔥"
User.destroy_all
Recipe.destroy_all

puts "seeding users 🌱"
5.times do
  user = User.new(
    email: Faker::Internet.email,
    encrypted_password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    # nationality: Faker::
    user_name: Faker::Internet.username,
  )
  user.save!
  3.times do
    Recipe.create!(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      instructions: Faker::Food.description,
      user_id: user.id,
      price: Faker::Number.decimal(l_digits: 2),
      number_of_people: Faker::Number.between(from: 1, to: 4),
    )
  end
end
puts "seeding recipe's 🌱"


puts "seeding finished 🌳☀️"
