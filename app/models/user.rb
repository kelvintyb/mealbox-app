class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :transactions
  # validates :name, presence: { message: "Please provide a name." }, length: {"Invalid name found"}
  # validates :contactno, uniqueness: true, length: { minimum: 8}

  # validates :creditcard,  length: {minimum: 16, maximum: 16, message: "Please enter a 16 digit credit card number(without spaces)." }
  # validates :creditcard,  presence: { message: "Please enter your credit card number" }
  # 
  # validates :address1, presence: { message: "Please enter your address"}
  # validates :address2,  presence: { message: "Please enter your apartment/unit"}


end
