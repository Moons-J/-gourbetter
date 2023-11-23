class RemoveAverageRatingFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :average_rating, :float
  end
end
