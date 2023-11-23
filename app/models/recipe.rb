class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :purchases
  has_many :ratings

  accepts_nested_attributes_for :recipe_ingredients

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :price, presence: true
  validates :category, presence: true
  validates :number_of_people, numericality: { only_integer: true }
  validates :instructions, presence: true, length: { minimum: 20 }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :description , :category ],
    associated_against: {
      ingredients: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
