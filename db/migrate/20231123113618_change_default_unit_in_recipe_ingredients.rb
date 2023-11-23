class ChangeDefaultUnitInRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column_default :recipe_ingredients, :unit, from: nil, to: "grams"
  end
end
