class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :purchases
  has_many :ratings
end
