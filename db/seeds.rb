# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ingredients = ['Red chili flakes', 'Black peppercorns', 'Coriander
','Fennel seeds
','Paprika
','Oregano
','Turmeric
','Whole nutmeg
','Bay leaves
','Cayenne pepper
','Thyme
','Cinnamon
','Panko bread crumbs
','Pasta
','Couscous
','Rice
','All-purpose flour
','White sugar
','Brown sugar
','Powdered sugar
','Baking powder
','Active dry yeast
','Chicken stock
','Beef stock
','Butter
','Heavy cream
','Eggs
','Parmesan
','Bacon
','Parsley
','Celery
','Carrots
','Lemons
','Limes
','Orange juice
','Ketchup
','Mayonnaise
','Extra virgin olive oil
','vegetable oil
','Canola/olive oil
','Vinegar
','Mustard
','Honey
','Garlic
','Shallots
','Potatoes — Idaho
','Onions — yellow
','Onions — red
','Tomatoes
','Black Pepper
','Cumin
','Coriander
','Bay Leaves
','Paprika
','Cayenne
','Fennel
','Turmeric
','Cinnamon
','Nutmeg
','Thyme
','Oregano
','Chile Powder
','Chile Flakes']

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

puts "seeding ingrediants 🌱"
ingredients.each do |ingrediant|
  Ingredient.create!(
    name: ingrediant,
  )
end

puts "seeding usable user 👨🏽‍🌾"
user = User.create!(
  email: "barttender@gmail.com",
  password: "123456",
  first_name: "Bart",
  last_name: "Tender",
  nationality: 'Begium',
  user_name: "BarTTender",
)
recipe = Recipe.create!(
  title: "Creamy Pasta Bake with Cherry Tomatoes and Basil",
  description: "This creamy pasta bake is one of my favorite midweek pasta dishes. My whole family loves it, and there is not much prep. Once the pasta bake is in the oven, you can make a salad or set the table, and then it's time to eat.",
  instructions: "Preheat the oven to 400 degrees F (200 degrees C). Grease a baking dish.
  Bring a large pot of lightly salted water to a boil. Add penne and cook, stirring occasionally, until tender yet firm to the bite, about 11 minutes. Drain, reserving 1 cup cooking water.
  Heat olive oil in a large skillet over medium heat. Cook onion in oil until soft and translucent, about 5 minutes. Add garlic and cook for an additional 30 seconds. Stir in tomato sauce and tomato paste and cook until slightly reduced, about 5 minutes. Add cream and Parmesan cheese. Season with sugar, salt, and pepper.
  Stir some of the reserved pasta water into sauce and add cooked penne. Remove from the heat and stir in cherry tomatoes, 1/2 of the mozzarella cheese, and basil. Add more pasta water if needed to reach desired consistency. Pour penne mixture into the prepared baking dish and cover with remaining mozzarella cheese.
  Bake in the preheated oven until bubbly and cheese is melted, about 20 minutes.",
  category: "Italian",
  user_id: user.id,
  price: Faker::Number.decimal(l_digits: 1),
  number_of_people: 6,
)
puts "seeding recipe ingredients 🌱"
8.times do
  RecipeIngredient.create!(
    recipe_id: recipe.id,
    ingredient_id: Ingredient.all.sample.id,
    amount: Faker::Number.between(from: 1, to: 4),
    unit: Faker::Food.measurement,
  )
end

puts "seeding purchases 🌱"
20.times do
  Purchase.create!(
    user_id: user.id,
    recipe_id: Recipe.all.sample.id,
    total_price: Faker::Number.decimal(l_digits: 2),
  )
end

Recipe.create!(
  title: Faker::Food.dish,
  description: Faker::Food.description,
  instructions: Faker::Food.description,
  category: Faker::Food.ethnic_category,
  user_id: user.id,
  price: Faker::Number.decimal(l_digits: 2),
  number_of_people: Faker::Number.between(from: 1, to: 4),
)

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

  puts "seeding a recipe 🍉"
  3.times do
    Recipe.create!(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      instructions: Faker::Food.description,
      category: Faker::Food.ethnic_category,
      user_id: user.id,
      price: Faker::Number.decimal(l_digits: 2),
      number_of_people: Faker::Number.between(from: 1, to: 4),
    )
  end
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
100.times do
  Rating.create!(
    comment: Faker::Restaurant.review,
    rating: Faker::Number.between(from: 1, to: 5),
    recipe_id: Recipe.all.sample.id,
    user_id: User.all.sample.id,
  )
end

puts "seeding purchases 🌱"
30.times do
  Purchase.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    total_price: Faker::Number.decimal(l_digits: 2),
  )
end

puts "seeding finished 🌳☀️"
