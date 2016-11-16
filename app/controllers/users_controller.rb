class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @transactions = @user.transactions
  end

  def show_user_recipes
    # @recipes = Recipe.where("user_id = ?", current_user.id)
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def show_user_transactions
    @user = User.find(params[:id])
    @transactions = @user.transactions
    @recipes = @user.recipes
    # @transactions = Transaction.where("user_id = ?", current_user.id)
    # @recipes = Recipe.where("user_id = ?", current_user.id)
  end
end
