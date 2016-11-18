class RecipesController < ApplicationController
before_filter "save_my_previous_url", only: [:show]

  def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
  end

  # path /recipes.json will render all recipes in json format
  def index
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    @recipes = Recipe.all
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  # add 1 view count to recipe when viewed
  # @recipesfromother finds recipes under the same cuisine
  def show
    Recipe.increment_counter(:views, params[:id])
    @recipe = Recipe.find(params[:id])
    current_cuisine = @recipe.cuisine
    @ingredients  = Ingredient.all
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    @recipesfromother = Recipe.where("cuisine = ?" , "#{current_cuisine}")

    # split the instructions into an array by the text Step [no]
    number = (/Step\s[0-9]/)
    @instructions = @recipe.instructions.split(number)
    puts @instructions.to_a

# NOTE whats this for?
    session[:curr_recipe_id] = params[:id]

    # path /recipe/:id.json will render the recipe details in json
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def search
    # if cuisine exists in the cuisine list, run search
    cuisine_list = ["All", "Western", "Indian", "Malay","Chinese"]
    if cuisine_list.index(params[:cuisine]) != nil
      # if query exists, search by cuisine and query
      if params[:query] != ""
        # downcase query as ingredients are downcased
        query = params[:query].downcase
        if params[:cuisine] == "All"
          @recipes = Recipe.where("name ILIKE ?", "%#{query}%")
        else
          @recipes = Recipe.where(["cuisine = ? and name ILIKE ?","#{params[:cuisine]}","%#{query}%"])
        end
      # if query does not exists, search by cuisine
      else
        if params[:cuisine] == 'All'
          @recipes = Recipe.all
        else
          @recipes = Recipe.where("cuisine = ?" , "#{params[:cuisine]}")
        end
      end
    end
    # return the search results as a json to the js (application)
    render json: {
      'search_recipes': @recipes
    }
  end

  #NOTE: ##############
  # below snippet only for the logic of 1)filtering by cuisine, 2) ordering by no. of views and 3) limiting first 3 in the order. Can uncomment below block and change the "if" in line 50 to "elsif" to test varying inputs through /browse/cuisine/Featured
  #####################
  # if params[:cuisine] == "Featured"
  #   @recipes = Recipe.where("cuisine = 'Indian'").order("views DESC").limit(3)

  # if user not login, redirect them to login page with notice
  def new
    if !user_signed_in?
      redirect_to new_user_session_path, notice: "You need to log in before you can create a recipe!"
    end

# NOTE why used gon
    gon.ingredients = Ingredient.all
    @recipe = Recipe.new
    @users = User.all
    @ingredients  = Ingredient.all
    @category_list = ["meat", "seafood", "vegetables", "condiments", "dairy and eggs","grains"]
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

  # if user not login or not the creator of recipe, redirect to root with notice
  def edit
    if !current_user || current_user.id != @recipe.user_id
      redirect_to root_path, notice: "You cannot edit other people's recipe'!"
    end

# NOTE why used gon
    gon.ingredients = Ingredient.all
    @recipe = Recipe.find(params[:id])
    @users = User.all
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

  # from new recipe form
  # save a new recipe with the form params
  def create
   @recipe = Recipe.new(recipe_params)
   user = User.find(params[:recipe][:user_id])
   @recipe.user = user
   @recipe.save
   @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
   @category_list = ["vegetables", "condiments", "dairy and eggs","grains"]

   # recipe_cost variable to store cost of ingredient * qty
   # save to recipe_ing table only if new recipe saved successfully
   recipe_cost = 0
   if @recipe.save
     # params recipe_ingredient_json is a string as form can only pass params as string
     # parse json string as into JSON array
     # for each ingredient added to recipe, save it to rec_ing table
     ing_array = JSON.parse(params[:recipe_ingredient_json])
     ing_array.each do |ingredient|
       recipe_ingredient = RecipeIngredient.new()

       # because rec_ing model belongs to recipe & ingredient, can store the object from find in recipe_ingredient.recipe
       recipe_ingredient.recipe = Recipe.find(@recipe.id)
       recipe_ingredient.ingredient = Ingredient.find_by(name: ingredient["ing"])
       recipe_ingredient.quantity = ingredient["qty"]
       recipe_ingredient.save
       recipe_cost += (recipe_ingredient.ingredient["cost"] * ingredient["qty"])
     end
     # after calculating ingredients, save recipe_cost into the recipe
     @recipe = Recipe.find(@recipe.id)
     @recipe.costperserving = recipe_cost
     @recipe.save
     redirect_to recipes_path
   else
# NOTE whats going on here
     gon.ingredients = Ingredient.all
     render 'new'
   end
  end

  # when editing recipe, return error if wrong
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
