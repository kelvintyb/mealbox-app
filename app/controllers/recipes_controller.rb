class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def show
    Recipe.increment_counter(:views, params[:id])
    @recipe = Recipe.find(params[:id])
    @ingredients  = Ingredient.all

    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def browse
    if params[:query]
      @recipes = Recipe.where(["cuisine = ? and name LIKE ?","#{params[:cuisine]}","%#{params[:query]}%"])
    else
      @recipes = Recipe.find_by cuisine: params[:cuisine]
    end
  end


  def new
    @recipe = Recipe.new
    @users = User.all
    @ingredients  = Ingredient.all
  end

  def edit
   @recipe = Recipe.find(params[:id])
   @users = User.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    user = User.find(params[:recipe][:user_id])
    @recipe.user = user
    @recipe.save
    recipecost = 0
    if @recipe.save
      array = JSON.parse(params[:recipe_ingredient_json])
      array.each do |ingredient|
        recipe_ingredient = RecipeIngredient.new()
        recipe_ingredient.recipe = Recipe.find(@recipe.id)
        recipe_ingredient.ingredient = Ingredient.find_by(name: ingredient["ing"])
        recipe_ingredient.quantity = ingredient["qty"]
        recipe_ingredient.save
        recipecost += (recipe_ingredient.ingredient["cost"] * ingredient["qty"])
      end
      @recipe = Recipe.find(@recipe.id)
      @recipe.costperserving = recipecost
      @recipe.save
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
      params.require(:recipe).permit(:name, :cuisine, :costperserving, :instructions, :image)
    end
end
