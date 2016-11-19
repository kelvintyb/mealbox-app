class TransactionsController < ApplicationController

  # if user is not logged in, all routes in transaction controller will be blocked
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!

 #require gems for braintree to work
  require 'rubygems'
  require 'braintree'

# set up to link sandbox braintree account to mealbox
Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = 'qhvsx3j5rz5rkcwf'
Braintree::Configuration.public_key = '7zq4kbksd89j2bm3'
Braintree::Configuration.private_key = '0ca8b42366943cff7364e59322b71e9f'

#technically, transaction does not have an index so instead of a 404 directed to new_transaction_path

  def index
    @transaction = Transaction.all
    @user = User.all

    redirect_to new_transaction_path
  end

#allow user to only see their own transaction details instead of everyone's
  def show
    redirect_to show_user_transactions_path
  end

#session[:curr_recipe_id] is an integer inherited from recipe controller. this is for rendering recipe details on the transaction page.
  def new

    @transaction = Transaction.new
    @user = User.new
    @recipe = Recipe.find(session[:curr_recipe_id])
    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
    # @recipe = Recipe.find(1)
    # session[:curr_recipe_id]
    #
    if user_signed_in? == 'nil'
      redirect_to new_user_registration_path

    end
  end

#session[:curr_recipe_id] is an integer inherited from recipe controller. this is for calculating the totalserving cost using recipe.costperserving

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

    @transaction.totalcost =
    (@recipe.costperserving * @transaction.totalserving.to_f)

    @transaction.user_id = @user.id
    @transaction.recipe_id = @recipe.id

    @user.save
    @transaction.save

    # if transaction is successfully saved. it is redirected to its own page with the paypal action
    if @transaction.save
      redirect_to :action=>"paypal", :controller=>"transactions", :transaction_id=>@transaction.id
    else
      render 'new'
    end
  end

 #self explanatory
  def edit
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(@transaction.recipe_id)
    @user = User.find(current_user.id)

    @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

 #self explanatory
  def update
    @transaction = Transaction.find(params[:id])
    @recipe = Recipe.find(@transaction.recipe_id)
    @user = User.find(current_user.id)

    @user.save

      if @transaction.update(transaction_params)
        redirect_to @transaction
      else
        render 'edit'
      end

  end

#self explanatory
  def destroy
    @user = User.find(current_user.id)
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    redirect_to root_path
  end

#session[:curr_transaction_id] is stored as an integer so it can be used to calculate the @transaction.totalcost in the POST checkout route

#@token is a randomly generated hash by braintree to secure payment. it is called in the paypal.erb page again.

  def paypal
    @transaction = Transaction.find(params[:transaction_id])

    session[:curr_transaction_id] = params[:transaction_id]

    @token = Braintree::ClientToken.generate
  end

#nonce is a randomly generated hash by brain tree to secure and verify payment. braintree will match @token and [:payment_method_nonce] to track and display payment in the sandbox page(i think?).


  def checkout
    @transaction = Transaction.find(session[:curr_transaction_id])

    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
    :amount => @transaction.totalcost,
    :payment_method_nonce => nonce,
    :options => {
      :submit_for_settlement => true
      }
    )

  # NOTE: IDK why but you can ONLY redirect result.success? to a STATIC PAGE. if you redirect it to anywhere else, the transaction will fail

    if result.success? || result.transaction
      redirect_to success_path
    else
      redirect_to failure_path
    end
  end


   private
    def transaction_params
      params.require(:transaction).permit(:deliverydate, :deliverytime, :address1, :address2)
    end

end
