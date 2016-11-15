class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :deliverydate,  presence: { message: "Please choose your delivery date." }
  validates :deliverytime, presence: { message: "Please choose your delivery time." }
  validates :totalserving, :numericality => { :less_than_or_equal_to => 20, message: "The maximum serving is 20" }
  validates :totalserving, :numericality => { :greater_than_or_equal_to => 1, message: "Minimum serving is 1" }

  validates :totalserving,  presence: { message: "Please choose how many servings you want." }

  validates :creditcard,  length: {:is => 16, message: "Please enter a 16 digit credit card number(without spaces)." }
  validates :creditcard,  presence: { message: "Please enter your credit card number" }

  validates :address1, presence: { message: "Please enter your address"}
  validates :address2,  presence: { message: "Please enter your apartment/unit"}

end
