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
end
