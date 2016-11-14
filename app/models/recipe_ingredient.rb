class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  # validates :ingredient_id, presence: { message: "Please choose at least one ingredient for your recipe." }
  # validates :quantity, :numericality => { :more_than_or_equal_to => 1, message: "lease choose the quantity of your ingredients." }

end
