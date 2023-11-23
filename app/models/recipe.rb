class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :purchases
  has_many :ratings
  has_one_attached :photo

  accepts_nested_attributes_for :recipe_ingredients

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :number_of_people, numericality: { only_integer: true, greater_than: 0 }
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

  def average_rating_bis
    return 0 if ratings.empty?

    (ratings.pluck(:rating).sum / ratings.count.to_f).round(1)
  end
end
