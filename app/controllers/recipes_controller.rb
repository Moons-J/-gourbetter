class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @recipes = Recipe.where("title LIKE ?", "%#{params[:query]}%")
    else
      @recipes = Recipe.all
    end
  end
end
