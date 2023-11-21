# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.new(
  email: "hhelo@gmail.com",
  password: "123456",
  first_name: "Jonas",
  last_name: "moons",
  # nationality: Faker::
  user_name: "moons.j",
)
user.save!


3.times do
  Recipe.create!(
    title: "Food ",
    description: "bla bla bla",
    instructions: "bla bla bla",
    user_id: 1,
    price: 11,
    number_of_people: 2,
  )
end
