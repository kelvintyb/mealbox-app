class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.all
    @user = User.all
  end
  def show
    @recipe = Recipe.find(params[:id])
    @transaction = Transaction.all
  end
  def new
    @transaction = Transaction.new
    @user = User.new
  end
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    # @transaction.recipe_id = sessions[curr_recipe_id]
    @transaction.save
    # @user = User.find(current_user.id)
    # @user.creditcard = params[:user][:creditcard]
    # @user.save
    # redirect to root_path
    if @transaction.save
      render "show"
      end
    end
  private
    def transaction_params
      params.require(:transaction).permit(:deliverydate, :deliverytime)
    end
  end
