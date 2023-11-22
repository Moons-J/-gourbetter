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

puts "clearing RecipeIngredient 🔥"
RecipeIngredient.destroy_all
puts "clearing Rating 🔥"
Rating.destroy_all
puts "clearing Purchases 🔥"
Purchase.destroy_all
puts "clearing Recipe 🔥"
Recipe.destroy_all
puts "clearing User 🔥"
User.destroy_all
puts "clearing Ingredient 🔥"
Ingredient.destroy_all

puts "seeding users 🌱"
5.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nationality: Faker::Address.country,
    user_name: Faker::Internet.username,
  )
  user.save!

  3.times do
    puts "seeding a recipe 🍉"
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

puts "seeding ingrediants 🌱"
20.times do
  Ingredient.create!(
    name: Faker::Food.ingredient,
  )
end

puts "seeding recipe ingrediants 🌱"
30.times do
  RecipeIngredient.create!(
    recipe_id: Recipe.all.sample.id,
    ingredient_id: Ingredient.all.sample.id,
    amount: Faker::Number.between(from: 1, to: 4),
    unit: Faker::Food.measurement,
  )
end

puts "seeding ratings 🌱"
50.times do
  Rating.create!(
    comment: Faker::Restaurant.review,
    rating: Faker::Number.between(from: 1, to: 5),
    recipe_id: Recipe.all.sample.id,
    user_id: User.all.sample.id,
  )
end

puts "seeding purchases 🌱"
20.times do
  Purchase.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    total_price: Faker::Number.decimal(l_digits: 2),
  )
end

puts "seeding finished 🌳☀️"
