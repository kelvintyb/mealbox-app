class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  before_save { name.downcase! }
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :cost, presence: true
  validates :qtyunit, presence: true
end
