class RecipesController < ApplicationController
before_filter "save_my_previous_url", only: [:show]

def save_my_previous_url
# session[:previous_url] is a Rails built-in variable to save last url.
session[:my_previous_url] = URI(request.referer || '').path
end

  def index

    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    @recipes = Recipe.all
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
      format.xml { render xml: @recipes }
    end

  end

  def show
    Recipe.increment_counter(:views, params[:id])
    @recipe = Recipe.find(params[:id])
    current_cuisine = @recipe.cuisine
    @ingredients  = Ingredient.all
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    @recipesfromother = Recipe.where("cuisine = ?" , "#{current_cuisine}")

    number = (/Step\s[0-9]/)

    @instructions = @recipe.instructions.split(number)

    puts @instructions.to_a

    session[:curr_recipe_id] = params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def search
    # NOTE:must downcase search terms here when db only downcases
    if params[:query] != ""
      redirect_to search_recipe_in_cuisine_path(params[:cuisine],params[:query])
    else
      redirect_to search_cuisine_path(params[:cuisine])
    end
  end

  def browse
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    @query = params[:cuisine]

    #NOTE: ##############
    # below snippet only for the logic of 1)filtering by cuisine, 2) ordering by no. of views and 3) limiting first 3 in the order. Can uncomment below block and change the "if" in line 50 to "elsif" to test varying inputs through /browse/cuisine/Featured
    #####################
    # if params[:cuisine] == "Featured"
    #   @recipes = Recipe.where("cuisine = 'Indian'").order("views DESC").limit(3)

    #NOTE: for "All" cuisine search, will nd to implement "All" list option in search bar partial
    if params[:cuisine].downcase == "all"
      @recipes = Recipe.where("name LIKE ?", "%#{params[:query]}%")
    elsif params[:query]
      @recipes = Recipe.where(["cuisine = ? and name LIKE ?","#{params[:cuisine]}","%#{params[:query]}%"])
    else
      @recipes = Recipe.where("cuisine = ?" , "#{params[:cuisine]}")
    end
  end

  def new

    if !user_signed_in?
      redirect_to new_user_session_path, notice: "You need to log in before you can create a recipe!"
    end

    gon.ingredients = Ingredient.all
    @recipe = Recipe.new
    @users = User.all
    @ingredients  = Ingredient.all
    @category_list = ["meat", "seafood", "vegetables", "condiments", "dairy and eggs","grains"]
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

  def edit

    if !current_user || current_user.id != @recipe.user_id
      redirect_to root_path, notice: "You cannot edit other people's recipe'!"
    end

   gon.ingredients = Ingredient.all
   @recipe = Recipe.find(params[:id])
   @users = User.all
   @cuisine_list = ["Western", "Indian", "Malay","Chinese"]

  end

  def create
   @recipe = Recipe.new(recipe_params)
   user = User.find(params[:recipe][:user_id])
   @recipe.user = user
   @recipe.save
   @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
   @category_list = ["vegetables", "condiments", "dairy and eggs","grains"]
   recipe_cost = 0
   if @recipe.save
     ing_array = JSON.parse(params[:recipe_ingredient_json])
     ing_array.each do |ingredient|
       recipe_ingredient = RecipeIngredient.new()
       recipe_ingredient.recipe = Recipe.find(@recipe.id)
       recipe_ingredient.ingredient = Ingredient.find_by(name: ingredient["ing"])
       recipe_ingredient.quantity = ingredient["qty"]
       recipe_ingredient.save
       recipe_cost += (recipe_ingredient.ingredient["cost"] * ingredient["qty"])
     end
     @recipe = Recipe.find(@recipe.id)
     @recipe.costperserving = recipe_cost
     @recipe.save
     redirect_to recipes_path
   else
     gon.ingredients = Ingredient.all
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
