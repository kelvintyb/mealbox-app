class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def show
      @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
   @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredients_path
    else
      render 'new'
    end
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

  def searchpost
    keyword = params[:q]
    appid = "b4b15aeb"
    appkey = "cd0ec70b471170cb6dd54055513ef1d5"
    @search = HTTParty.get("https://api.nutritionix.com/v1_1/search/#{keyword}?results=0%3A5&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=#{appid}&appKey=#{appkey}",
    headers:{
      "Accept" => "application/json"
    })
    logger.debug "Trying to search for #{@search}"
    render json: {
      'result': @search["hits"]
    }
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name, :category, :cost, :qtyunit)
    end
end
