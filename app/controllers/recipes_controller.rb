class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    @rating = Rating.new # for the form adding ratings
  end

  def index
    set_recipes_average_rating
    if params[:query].present?
      @query = params[:query]
      @recipes = params[:rating].present? ? order_recipes(params[:rating], params[:query]) : Recipe.global_search(params[:query])
    else
      @recipes = params[:rating].present? ? order_recipes(params[:rating]) : Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.new
  end

  def create
    @recipe = Recipe.new(recipes_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_recipes(keyword, query = nil)
    if query.nil?
      if keyword == "top"
        return Recipe.all.sort_by(&:average_rating).reverse # changes need to be made here
      else
        return Recipe.all.sort_by(&:average_rating)
      end
    else
      if keyword == "top"
        return Recipe.global_search(query).sort_by(&:average_rating).reverse
      else
        return Recipe.global_search(query).sort_by(&:average_rating)
      end
    end
  end

  def recipes_params
    params.require(:recipe).permit(:title, :description, :price, :category,
                                   :number_of_people, :instructions, :photo)
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
