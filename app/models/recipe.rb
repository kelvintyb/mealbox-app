class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :transactions
  validates :user, presence: true
  validates :name, presence: true
  validates :cuisine, presence: true
  validates :costperserving, presence: true
  validates :views, presence: true
  validates :instructions, presence: true
  validates :image, presence: true
end
