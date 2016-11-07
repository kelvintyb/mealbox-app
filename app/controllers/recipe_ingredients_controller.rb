class RecipeIngredientsController < ApplicationController
  def create
    recipe_ingredient = RecipeIngredient.new()
    recipe_ingredient.recipe = Recipe.find(params[:recipe_id])
    recipe_ingredient.ingredient = Ingredient.find(params[:recipe_ingredient][:ingredient_id])
    recipe_ingredient.quantity = params[:recipe_ingredient][:quantity]
    recipe_ingredient.save
    redirect_to recipe_path((params[:recipe_id]))
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find((params[:id]))
    @recipe_ingredient.destroy
    redirect_to recipe_path((params[:recipe_id]))
  end

end
