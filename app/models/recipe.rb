class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :transactions
  # validates :name, presence: true
  # validates :cuisine, presence: true
  # validates :costperserving, presence: true
  # validates :instructions, presence: true
  # validates :image, presence: true
end
