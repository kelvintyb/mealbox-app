# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

onion = Ingredient.create :name => "Onion", :category => "Vegetables", :cost => 0.70, :qtyunit => "NOS"

garlic = Ingredient.create :name => "Garlic", :category => "Vegetables", :cost => 0.20, :qtyunit => "clove"

tumeric_powder = Ingredient.create :name => "Tumeric Powder", :category => "Condiments", :cost => 0.30, :qtyunit => "TBSP"

cream = Ingredient.create :name => "Cream", :category => "Dairy and Eggs", :cost => 0.30, :qtyunit => "100ml"

paneer = Ingredient.create :name => "Paneer", :category => "Dairy and Eggs", :cost => 1.70, :qtyunit => "100g"

ginger = Ingredient.create :name => "Ginger", :category => "Vegetable", :cost => 0.60, :qtyunit => "100g"

spinach = Ingredient.create :name => "Spinach", :category => "Vegetable", :cost => 0.50, :qtyunit => "100g"

tomato = Ingredient.create :name => "Tomato", :category => "Vegetable", :cost => 0.50, :qtyunit => "100g"

basmati_rice = Ingredient.create :name => "Basmati Rice", :category => "Grains", :cost => 0.80, :qtyunit => "100g"
