class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :dateandtime,  presence: { message: "Please enter your delivery date and time." }

  validates :totalserving, :numericality => { :less_than_or_equal_to => 20, message: "The maximum serving is 20" }
  validates :totalserving, :numericality => { :greater_than_or_equal_to => 1, message: "Minimum serving is 1" }

  validates :totalserving,  presence: { message: "Please choose how many servings you want." }

  validates :address1, presence: { message: "Please enter your address"}
  validates :address2,  presence: { message: "Please enter your apartment/unit"}

end
