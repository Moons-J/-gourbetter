class RatingsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @rating = Rating.new(rating_params)
    @rating.recipe = @recipe
    @rating.user = current_user
    respond_to do |format|
      if @rating.save
        format.html { redirect_to recipe_path(@recipe) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render recipe_path(@recipe), status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :comment)
  end
end
