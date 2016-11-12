class TransactionsController < ApplicationController

  def index
    @transaction = Transaction.all
    @user = User.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(session[:curr_recipe_id])
  end

  def new
    @transaction = Transaction.new
    @user = User.new
    @recipe = Recipe.find(session[:curr_recipe_id])
    # @recipe = Recipe.find(1)
    # session[:curr_recipe_id]
  end

  def create
    @transaction = Transaction.new()
    @transaction.deliverydate = params[:transaction][:deliverydate]
    @transaction.deliverytime = params[:transaction][:deliverytime]
    @transaction.totalserving = params[:transaction][:totalserving]


    @recipe = Recipe.find(session[:curr_recipe_id])
    @user = User.find(current_user.id)
    # @recipe = Recipe.find(back_recipe.id)

    @user.creditcard = params[:user][:creditcard]

    @transaction.totalcost =
    (@recipe.costperserving * @transaction.totalserving.to_f)

    @transaction.user_id = @user.id
    @transaction.recipe_id = @recipe.id

    # @transaction.recipe_id = @recipe_id.id
    # @transaction.recipe_id = sessions[curr_recipe_id]

    # @recipe.save
    @user.save
    @transaction.save

    # redirect to root_path
    if @transaction.save && @user.save
      # redirect_to controller: 'transactions', id: params[:id]
      redirect_to @transaction
    else
      redirect_to root_path
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(session[:curr_recipe_id])
    @user = User.find(current_user.id)
  end

  def update
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(session[:curr_recipe_id])
    @user = User.find(current_user.id)

    @transaction.totalserving = params[:transaction][:totalserving]

    @transaction.totalcost =
    (@recipe.costperserving * @transaction.totalserving.to_f)

    @user.creditcard = params[:user][:creditcard]

    # @transaction.deliverydate = params[:transaction][:deliverydate]
    # @transaction.deliverytime = params[:transaction][:deliverytime]
    @user.save

      if @transaction.update(transaction_params)
        redirect_to @transaction
      else
        render 'edit'
      end

  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to root_path
  end

   private
    def transaction_params
      params.require(:transaction).permit(:deliverydate, :deliverytime, :totalserving)
    end

end
