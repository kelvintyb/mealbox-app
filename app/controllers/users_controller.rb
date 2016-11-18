class UsersController < ApplicationController

  def show
    if !current_user || !User.exists?(params[:id])
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @recipes = @user.recipes
      @transactions = @user.transactions
    end
  end

  def show_user_recipes
    if !current_user || !User.exists?(params[:id])
      redirect_to root_path
    else
      # @recipes = Recipe.where("user_id = ?", current_user.id)
      @user = User.find(params[:id])
      @recipes = @user.recipes
    end
  end

  def show_user_transactions
    if !current_user || !User.exists?(params[:id])
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @transactions = @user.transactions
      @recipes = @user.recipes
      # @transactions = Transaction.where("user_id = ?", current_user.id)
      # @recipes = Recipe.where("user_id = ?", current_user.id)
    end
  end
end
