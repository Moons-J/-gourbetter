class RatingsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @rating = Rating.new(rating_params)
    @rating.recipe = @recipe
    @rating.user = current_user
    if @rating.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/show"
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :comment)
  end
end
