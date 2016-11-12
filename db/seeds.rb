# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#t

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create :name => "example", :email => "example@gmail.com", :password => "123456"

onion = Ingredient.create :name => "onion", :category => "vegetables", :cost => 0.70, :qtyunit => "NOS"

garlic = Ingredient.create :name => "garlic", :category => "vegetables", :cost => 0.20, :qtyunit => "clove"

tumeric_powder = Ingredient.create :name => "tumeric powder", :category => "condiments", :cost => 0.30, :qtyunit => "TBSP"

cream = Ingredient.create :name => "cream", :category => "dairy and eggs", :cost => 0.30, :qtyunit => "100ml"

paneer = Ingredient.create :name => "paneer", :category => "dairy and eggs", :cost => 1.70, :qtyunit => "100g"

ginger = Ingredient.create :name => "ginger", :category => "vegetables", :cost => 0.60, :qtyunit => "100g"

spinach = Ingredient.create :name => "spinach", :category => "vegetables", :cost => 0.50, :qtyunit => "100g"

tomato = Ingredient.create :name => "tomato", :category => "vegetables", :cost => 0.50, :qtyunit => "100g"

basmati_rice = Ingredient.create :name => "basmati rice", :category => "grains", :cost => 0.80, :qtyunit => "100g"

palak_paneer = Recipe.create :name => "Palak Paneer", :cuisine => "Indian", :user_id => 1, :costperserving => 6.7, :views => 50, :instructions => "step 1 do this. step 2 do that. step 3 do this again", :image => "http://photos.vegrecipesofindia.com/wp-content/uploads/2013/05/palak-paneer-recipe.jpg"

chicken_rice = Recipe.create :name => "Chicken Rice", :cuisine => "Malay", :user_id => 1, :costperserving => 2.3, :views => 200, :instructions => "lets do this", :image =>"http://2.bp.blogspot.com/-XlifUsGbe8A/UXQRowm09TI/AAAAAAAABr8/4sLQzVK7S7I/s1600/DSC_5140-Farrari+Steam+Chicken+Rice.jpg"



1.upto(9) do |i|
 Recipe.find(1).recipe_ingredients.create ingredient_id:i, quantity:rand(1..5)
end
