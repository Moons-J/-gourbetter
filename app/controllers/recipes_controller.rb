class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    set_recipes_average_rating
    if params[:query].present?
      @query = params[:query]
      @recipes = params[:rating].present? ? order_recipes(params[:rating], params[:query]) : Recipe.where("title ILIKE :title", title: "%#{params[:query]}%")
    else
      @recipes = params[:rating].present? ? order_recipes(params[:rating]) : Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipes_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  private

  def order_recipes(keyword, query = nil)
    if query.nil?
      if keyword == "top"
        return Recipe.all.sort_by(&:average_rating).reverse
      else
        return Recipe.all.sort_by(&:average_rating)
      end
    else
      if keyword == "top"
        return Recipe.where("title ILIKE :title", title: "%#{query}%").sort_by(&:average_rating).reverse
      else
        return Recipe.where("title ILIKE :title", title: "%#{query}%").sort_by(&:average_rating)
      end
    end
  end

  def recipes_params
    params(:recipe).permit(:title, :description, :price, :category, :number_of_people)
  end

  def set_recipes_average_rating
    @recipes = Recipe.all
    @recipes.each do |recipe|
      ratings = recipe.ratings.pluck(:rating)
      sum = ratings.sum
      if sum.zero?
        recipe.update(average_rating: 0)
      else
        recipe.update(average_rating: (sum.to_f / ratings.count).round(1))
      end
    end
  end
end
