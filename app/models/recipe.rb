class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :purchases
  has_many :ratings

  accepts_nested_attributes_for :recipe_ingredients

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :number_of_people, numericality: { only_integer: true }
  validates :instructions, presence: true
end
