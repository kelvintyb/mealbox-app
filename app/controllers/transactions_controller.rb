class TransactionsController < ApplicationController

  skip_before_action :verify_authenticity_token

  require 'rubygems'
  require 'braintree'

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = 'qhvsx3j5rz5rkcwf'
Braintree::Configuration.public_key = '7zq4kbksd89j2bm3'
Braintree::Configuration.private_key = '0ca8b42366943cff7364e59322b71e9f'

  def index
    @transaction = Transaction.all
    @user = User.all

    redirect_to new_transaction_path
  end

  def show
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(@transaction.recipe_id)
    @user = User.find(current_user.id)
  end

  def new

    @transaction = Transaction.new
    @user = User.new
    @recipe = Recipe.find(session[:curr_recipe_id])
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    # @recipe = Recipe.find(1)
    # session[:curr_recipe_id]
  end

  def create

    @transaction = Transaction.new()
    @transaction.deliverytime = params[:transaction][:deliverytime]
    @transaction.deliverydate = params[:transaction][:deliverydate]
    @transaction.totalserving = params[:transaction][:totalserving]
    @transaction.address1 = params[:transaction][:address1]
    @transaction.address2 = params[:transaction][:address2]

    @user = User.find(current_user.id)

    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]

    @recipe = Recipe.find(session[:curr_recipe_id])
    # @recipe = Recipe.find(back_recipe.id)

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
    if @transaction.save
      redirect_to :action=>"paypal", :controller=>"transactions", :transaction_id=>@transaction.id
    else
      render 'new'
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(@transaction.recipe_id)
    @user = User.find(current_user.id)

    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

  def update
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(@transaction.recipe_id)
    @user = User.find(current_user.id)

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

  def paypal
    @transaction = Transaction.find(params[:transaction_id])

    session[:curr_transaction_id] = params[:transaction_id]

    @token = Braintree::ClientToken.generate

    # puts "HAHAHAHAHA"
    # puts @token
    #
    # nonce = params["payment_method_nonce"]
    #
    # result = Braintree::Transaction.sale(
    #   amount: 10,
    #   payment_method_nonce: nonce,
    #   :options => {
    #     :submit_for_settlement => true
    #   }
    # )
    # if result.success? || result.transaction
    #   redirect_to checkout_path(result.transaction.id)
    # else
    #   error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
    #   flash[:error] = error_messages
    #   redirect_to root_path
    # end

  end

  def checkout
    @transaction = Transaction.find(session[:curr_transaction_id])

    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
    :amount => @transaction.totalcost, #could be any other arbitrary amount captured in params[:amount] if they weren't all $10.
    :payment_method_nonce => nonce,
    :options => {
      :submit_for_settlement => true
      }
    )

    if result.success? || result.transaction
      redirect_to success_path
    else
      debugger
      render html: 'Failed'
    end
  end


   private
    def transaction_params
      params.require(:transaction).permit(:dateandtime, :deliverydate, :deliverytime, :address1, :address2)
    end

end
