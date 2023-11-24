class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    @rating = Rating.new # for the form adding ratings
  end

  def index
    if params[:query].present?
      @query = params[:query]
      @recipes = params[:rating].present? ? order_recipes(params[:rating], params[:query]) : Recipe.global_search(params[:query]).reverse
    else
      @recipes = params[:rating].present? ? order_recipes(params[:rating]) : Recipe.all.reverse
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

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_ingredients
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipes_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def order_recipes(keyword, query = nil)
    if query.nil?
      if keyword == "top"
        return Recipe.all.sort_by(&:average_rating_bis).reverse # changes need to be made here
      else
        return Recipe.all.sort_by(&:average_rating_bis)
      end
    else
      if keyword == "top"
        return Recipe.global_search(query).sort_by(&:average_rating_bis).reverse
      else
        return Recipe.global_search(query).sort_by(&:average_rating_bis)
      end
    end
  end

  def recipes_params
    params.require(:recipe).permit(:title, :description, :price, :category,
                                   :number_of_people, :instructions, :photo,
                                   recipe_ingredients_attributes: [:amount, :unit, :ingredient_id])
  end
end
