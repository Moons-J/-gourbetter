class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
end
