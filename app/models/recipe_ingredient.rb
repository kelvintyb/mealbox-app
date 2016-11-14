class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :ingredient_id, presence: { message: "Please choose at least one ingredient for your recipe." }
  validates :quantity, presence: { message: "Please choose the quantity of your ingredients." }

end
