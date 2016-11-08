class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    Recipe.increment_counter(:views, params[:id])
    @recipe = Recipe.find(params[:id])
    @ingredients  = Ingredient.all
  end

  def new
    @recipe = Recipe.new
    @users = User.all
  end

  def edit
   @recipe = Recipe.find(params[:id])
   @users = User.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def update
      @recipe = Recipe.find(params[:id])

      if @recipe.update(recipe_params)
        redirect_to @recipe
      else
        render 'edit'
      end
  end

    def destroy
      @recipe = Recipe.find(params[:id])
      @recipe.destroy
      redirect_to recipes_path
    end

  private
    def recipe_params
      params.require(:recipe).permit(:user_id, :name, :cuisine, :costperserving, :instructions, :image)
    end
end
