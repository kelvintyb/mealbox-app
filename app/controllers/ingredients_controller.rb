class IngredientsController < ApplicationController

  # for admin to search for ingredients
  def index

  end

  # admin wants to add ingredients
  def new
    ing_json = JSON.parse(params[:nutri_add_json])
    @ingredient.name = ing_json["item_name"]

  end

  def edit
   @ingredient = Ingredient.find(params[:id])
  end

  def create

    #   recipe_ingredient = RecipeIngredient.new()
    #   recipe_ingredient.recipe = Recipe.find(@recipe.id)
    #   recipe_ingredient.ingredient = Ingredient.find_by(name: ingredient["ing"])
    #   recipe_ingredient.quantity = ingredient["qty"]
    #   recipe_ingredient.save
    #   recipe_cost += (recipe_ingredient.ingredient["cost"] * ingredient["qty"])
    # end
    redirect_to transactions_path
    # @ingredient = Ingredient.new(ingredient_params)
    # if @ingredient.save
    #   redirect_to ingredients_path
    # else
    #   render 'new'
    # end
  end

  def update
      @ingredient = Ingredient.find(params[:id])

      if @ingredient.update(ingredient_params)
        redirect_to @ingredient
      else
        render 'edit'
      end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  def searchnutri
    keyword = params[:query]
    @appid = "b4b15aeb"
    @appkey = "cd0ec70b471170cb6dd54055513ef1d5"
    @search = HTTParty.get("https://api.nutritionix.com/v1_1/search/#{keyword}?results=0%3A5&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=#{@appid}&appKey=#{@appkey}")
    logger.debug "Trying to search for #{@search}"
    render json: {
      'result': @search["hits"]
    }
  end

  def searchingredient
    # nutritionixid = params[:nutri_id]
    puts (params[:nutritionixid])
  end

  private
    # def ingredient_params
    #   params.require(:ingredient).permit(:name, :category, :cost, :qtyunit)
    # end
end
