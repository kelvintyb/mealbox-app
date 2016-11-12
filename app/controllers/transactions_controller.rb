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
    # @recipe = Recipe.find(1)
    session[:curr_recipe_id]
  end

  def create
    @transaction = Transaction.new()
    @transaction.deliverydate = params[:transaction][:deliverydate]
    @transaction.deliverytime = params[:transaction][:deliverytime]

    @recipe = Recipe.find(session[:curr_recipe_id])
    @user = User.find(current_user.id)
    # @recipe = Recipe.find(back_recipe.id)

    @user.creditcard = params[:user][:creditcard]

    @transaction.user_id = @user.id
    @transaction.recipe_id = @recipe.id

    # @transaction.recipe_id = @recipe_id.id
    # @transaction.recipe_id = sessions[curr_recipe_id]

    # @recipe.save
    @user.save
    @transaction.save

    # redirect to root_path
    if @transaction.save && @user.save && @recipe.save
      render "show"
    else
      redirect_to root_path
    end
  end

  #  private
  #   def transaction_params
  #     params.require(:transaction).permit(:deliverydate, :deliverytime)
  #   end

end
