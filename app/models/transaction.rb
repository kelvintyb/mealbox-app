class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :deliverydate,  presence: true
  validates :deliverytime, presence: true
  validates :totalserving,  presence: true
end
