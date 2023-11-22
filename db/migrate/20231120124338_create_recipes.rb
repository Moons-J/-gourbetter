class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :instructions
      t.decimal :price
      t.references :user, foreign_key: true
      t.string :category
      t.integer :number_of_people
      t.float :average_rating

      t.timestamps
    end
  end
end
