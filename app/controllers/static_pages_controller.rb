class StaticPagesController < ApplicationController

  def home
      @recipes = Recipe.all
      @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

#success page for paypal
  def success
  end

  def failure
    @transaction = Transaction.find(session[:curr_transaction_id])

  end

end
