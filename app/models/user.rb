class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :transactions
  # validates :name, presence: { message: "Please provide a name." }, length: {"Invalid name found"}
  # validates :contactno, uniqueness: true, length: { minimum: 8}

end
