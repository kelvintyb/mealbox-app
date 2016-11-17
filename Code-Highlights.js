
/*=======
Nutritionix External API without
nutrition calculation code for views
=======*/

// ingredient controller
def admincheck
  if !current_user || current_user.id != 1
    redirect_to root_path, notice: "You cannot only add ingredients if you are an ADMIN!"
  end
end
// new.html.erb
<%= form_tag searchnutri_path, method: :post, remote: true, id: 'searchform' do %>
  <%= label_tag(:query, "Search for:")%>
  <%= text_field_tag(:query)%>
  <%= submit_tag("Search")%>
<% end %>
// ingredient controller POST searchnutri_path
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
// appid and appkey codes for external api nutritionix (100 calls per day)
@@appid = "b4b15aeb"
@@appkey = "cd0ec70b471170cb6dd54055513ef1d5"
// ingredient.js
$(document).on('turbolinks:load', function () {
$('#searchform').on('ajax:success', function (e, data, status) {
  $('.searchcontainer').text('')
  if (data.found !== 'not found') {
      $('.searchcontainer').append("<h2>Ingredient found in our database!</h2>")
  }
  if (data.result.length === 0) {
      $('.searchcontainer').append("<h2>Result not found!</h2>")
  }
  data.result.forEach(function (ingredient) {
    var newList = $('<li>')
    var newButton = $('<button class="add-ing" type="submit"><p>Add Ingredient</p>')
    newList.text(ingredient.fields.item_name)
    newButton.attr('value', ingredient.fields.item_id)
    $('.searchcontainer').append(newList)
    newList.append(newButton)
  })
  // val of this is the nutri id of the ingredient
  $('button.add-ing').on('click', function () {
    var ing_details = $(this).val()
    $('#nutri_id').val(ing_details)
  })
})
})
// new.html.erb for appending of results and POST
<%= form_tag searchingredient_path, method: :post, remote: true, id: 'nutri_ing_form' do %>
<%= hidden_field_tag 'nutri_id', "" %>
  <h2>Search Results</h2>
  <ul class="searchcontainer">
  </ul>
<% end %>
// ingredient controller
// redirect to show with the id provided
def searchingredient
  admincheck()
  redirect_to ingredient_path(params[:nutri_id])
end
// ingredient controller
// store ing details in class variable for later use
@@nutri_ingredient = ''
def show
  admincheck()
  @@nutri_ingredient = HTTParty.get("https://api.nutritionix.com/v1_1/item?id=#{params[:id]}&appId=#{@@appid}&appKey=#{@@appkey}")
  @nutri = @@nutri_ingredient
end
// show.html.erb
<%= form_tag ingredient_path, method: :patch do %>
  <p>
    <%= label_tag(:name, "Name")%>
    <%= text_field_tag :name, value = @nutri ['item_name'] %>
  </p>
  <p>
    <%= label_tag(:category, "Category")%>
    <%= text_field_tag :category, value = nil, placeholder: 'Ingredient Category' %>
  </p>
  <p>
    <%= label_tag(:cost, "Cost")%>
    <%= text_field_tag :cost, value = nil, placeholder: 'Ingredient Cost' %>
  </p>
// ingredient controller
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
      nutri_ingredient.qtyunit = params[:qtyunit]
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

  /*=======
  How nutri values are rendered (in ruby)
  =======*/
  <div class="boxes-mover">
      <div class="col-md-4 box">
          <span class="nutri-name">Total Fat</span>
          <span class="nutri-result">
            <%= sprintf("%.2f", @recipe.ingredients.inject(0) {|sum,x|
             x.attributes['fat'] ? sum + x.fat : sum + 0 } )
             %>g
        </span>
  </div>
  /*=======
  Masonry Implementation
  =======*/
/* scripts for masonry to work */
//= require imagesloaded.pkgd
//= require masonry.pkgd
/* views */
<div class="masonry-container">
<div class="grid-sizer"></div>
<% @recipes.each do |recipe| %>
<div class="thumbnail recipe-thumb grid-item">
<figure class="snip1268">
<div class="image">
<img src="<%= recipe.image %>" alt="sq-sample4">
<div class="icons">
<div class="recipe-views"><span class="glyphicon glyphicon-eye-open views-icon"></span><%= recipe.views %></div>
</div>
<%= link_to 'View Recipe', recipe_path(recipe), class:'view-recipe' %>
</div>
</figure>
<div id="ribbon">
<span id="content-cuisine"><%= recipe.cuisine %></span>
</div>
<div class="caption">
<h3><%= recipe.name %></h3>
</div>
</div>
<% end %>
</div>
</div>
/* initialize */
var $grid = $('.masonry-container').imagesLoaded( function() {
  $grid.masonry({
    itemSelector: '.grid-item',
    percentPosition: true,
    columnWidth: '.grid-sizer',
    gutter: 20
  });
});

/*=======
Ajax Implementation for Search
note: the code below is refactored from code
currently in production
=======*/

$(document).on('turbolinks:load', function () {
  $('.hero_search').on('ajax:success', function (e, data, status) {
    $('.hero_remove').empty()
    if (data == []){
      var QueryNotFound = `<h1>No recipes found. Please try again!</h1><span class="headerLine"></span><span class="add-recipe-btn"><i class="fa fa-plus" aria-hidden="true"></i><a href="/recipes/new">Add Recipe</a>
      </span><div style="clear:both;"></div>`
      $(".hero_remove").append(QueryNotFound)
    }
    else {
      var masonryStarter =  `<h1>Search Results</h1><span class="headerLine"></span><span class="add-recipe-btn"><i class="fa fa-plus" aria-hidden="true"></i><a href="/recipes/new">Add Recipe</a>
      </span><div class="recipe-all"><div class="masonry-container"><div class="grid-sizer"></div></div>
      </div><div style="clear:both;"></div>`
      $('.hero_remove').append(masonryStarter)
      var mediaItemContainer = $(".masonry-container")
      data.search_recipes.forEach(function(recipe){
        var masonryTile = `<div class="thumbnail recipe-thumb grid-item"><figure class="snip1268"><div class="image"><img src="${recipe.image}" alt="sq-sample4" class="hoverZoomLink"><div class="icons"><div class="recipe-views"><span class="glyphicon glyphicon-eye-open views-icon"></span>${recipe.views}</div></div><a class="view-recipe" href="/recipes/${recipe.id}">View Recipe</a></div></figure><div id="ribbon"><span id="content-cuisine">${recipe.cuisine}</span></div><div class="caption"><h3>${recipe.name}</h3></div></div>`
        mediaItemContainer.append(masonryTile)
        //ensure layout of masonry elements are adjusted
        mediaItemContainer.imagesLoaded(function () {
          mediaItemContainer.masonry({
            itemSelector: '.grid-item',
            percentPosition: true,
            columnWidth: '.grid-sizer',
            gutter: 20
          })
        })
        mediaItemContainer.masonry('reloadItems')
        mediaItemContainer.masonry('layout')
      })
    }
    console.log(data.search_recipes)
  })
})


/*=======
Implementation for Braintree API (in ruby)
=======*/
// gem file for braintree API
gem 'braintree'
// braintree is running in the sandbox of the merchant_id you provided
Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = 'qhvsx3j5rz5rkcwf'
Braintree::Configuration.public_key = '7zq4kbksd89j2bm3'
Braintree::Configuration.private_key = '0ca8b42366943cff7364e59322b71e9f'
// @token is to generate a random token to secure your payments. session is to store transaction_id to be used in checkout
def paypal
    @transaction = Transaction.find(params[:transaction_id])
    session[:curr_transaction_id] = params[:transaction_id]
    @token = Braintree::ClientToken.generate
end
// The payment method nonce is a string returned by the client SDK represent a payment method. This string is a reference to the customer payment method details that were provided in your payment form and should be sent to your sandbox.
def checkout
    @transaction = Transaction.find(session[:curr_transaction_id])
    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
    :amount => @transaction.totalcost
    :payment_method_nonce => nonce,
    :options => {
      :submit_for_settlement => true
      }
    )
    if result.success? || result.transaction
      redirect_to success_path
    else
      debugger
      render html: 'Failed'
    end
end
// @token doesn’t work in script. so you need to set a new var to reference @token.
<script>
var clientToken = "<%= @token %>"
braintree.setup(clientToken, 'dropin', {
  container: 'payment-form'
})
</script>
<form id="checkout" method="post" action="/checkout">
  <div id="payment-form"></div>
  <input type="submit" value="Click here to Pay" id="paybutton">
</form>
