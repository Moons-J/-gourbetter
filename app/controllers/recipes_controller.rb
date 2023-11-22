class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
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
end
