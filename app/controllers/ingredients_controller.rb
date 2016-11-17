class IngredientsController < ApplicationController

  # appid and appkey codes for external api nutritionix (100 calls per day)
  # nutri ingredient class variable, used for def update
  @@appid = "b4b15aeb"
  @@appkey = "cd0ec70b471170cb6dd54055513ef1d5"
  @@nutri_ingredient = ''

  # admin view all ingredients in db
  def index
    admincheck()
    @ingredients = Ingredient.all
  end

  # admin to search for ingredients to add
  def new
    admincheck()
  end

  # admin wants to add the ingredients
  # using the id from searchingredient post, do a get api call
  # save the data in the class variable for use later
  def show
    admincheck()
    @@nutri_ingredient = HTTParty.get("https://api.nutritionix.com/v1_1/item?id=#{params[:id]}&appId=#{@@appid}&appKey=#{@@appkey}")
    @nutri = @@nutri_ingredient
  end

  # if ingredient exists in db, render the show page
  # else save the ingredient in the db
  def update
    admincheck()
    found = Ingredient.find_by(name: params['name'])
    if found
      render 'show'
    else
      nutri_ingredient = Ingredient.new()
      nutri_ingredient.name = params[:name]
      nutri_ingredient.category = params[:category]
      nutri_ingredient.cost = params[:cost]
      nutri_ingredient.qtyunit = (@@nutri_ingredient ['nf_serving_size_qty']).to_s + ' ' + @@nutri_ingredient ['nf_serving_size_unit']
      nutri_ingredient.weightgram = @@nutri_ingredient['nf_serving_weight_grams']
      nutri_ingredient.calories = @@nutri_ingredient['nf_calories']
      nutri_ingredient.fat = @@nutri_ingredient['nf_total_fat']
      nutri_ingredient.cholesterol = @@nutri_ingredient['nf_cholesterol']
      nutri_ingredient.carbohydrate = @@nutri_ingredient['nf_total_carbohydrate']
      nutri_ingredient.protein = @@nutri_ingredient['nf_protein']
      nutri_ingredient.save
      redirect_to ingredients_path
    end
  end

  # find the ingredient in the db and delete it
  def destroy
    admincheck()
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  # if user search query exists in db, tell him it exists
  # search for the query using the nutritionix get api calls
  # return a json which can be retrieved in ing js using data.result or data.found
  def searchnutri
    admincheck()
    keyword = params[:query]
    ing_exist = Ingredient.find_by(name: keyword)
    if ing_exist
      ing_found = ing_exist
    else
      ing_found = 'not found'
    end
    @search = HTTParty.get("https://api.nutritionix.com/v1_1/search/#{keyword}?results=0%3A5&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=#{@@appid}&appKey=#{@@appkey}")
    render json: {
      'found': ing_found,
      'result': @search["hits"]
    }
  end

  # redirect to show with the id provided
  def searchingredient
    admincheck()
    redirect_to ingredient_path(params[:nutri_id])
  end

  private
    # if user is not login or not admin, redirect to root
    def admincheck
      if !current_user || current_user.id != 1
        redirect_to root_path, notice: "You cannot only add ingredients if you are an ADMIN!"
      end
    end
end
