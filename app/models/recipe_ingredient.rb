class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :amount, presence: true, numericality: { only_integer: true }
  validates :unit, presence: true
end
