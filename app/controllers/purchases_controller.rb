class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    recipe = Recipe.find(params[:recipe_id])

    purchase = Purchase.new()
    purchase.user = current_user
    purchase.recipe = recipe
    purchase.total_price = recipe.price
    if purchase.save
      redirect_to user_path(current_user)
    else
      render :new, status: 422
    end
  end
end
