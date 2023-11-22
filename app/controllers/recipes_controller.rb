class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    set_recipes_average_rating
    if params[:query].present?
      @query = params[:query]
      @recipes = Recipe.where("title ILIKE :title", title: "%#{params[:query]}%")
    else
      @recipes = Recipe.all
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
      render :new, 422
    end
  end

  private

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
