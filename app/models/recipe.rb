class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :purchases
  has_many :ratings
  has_one_attached :photo

  accepts_nested_attributes_for :recipe_ingredients

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :number_of_people, numericality: { only_integer: true, greater_than: 0 }
  validates :instructions, presence: true, length: { minimum: 20 }
end
