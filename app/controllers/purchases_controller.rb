class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :new

  def new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
  end
end
