class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where("user_id = ?", current_user.id).count(:id)
  end

  def show_user_recipes
    @recipes = Recipe.where("user_id = ?", current_user.id)

  end

  def show_user_transactions
    @transactions = Transaction.where("user_id = ?", current_user.id)
  end
end
