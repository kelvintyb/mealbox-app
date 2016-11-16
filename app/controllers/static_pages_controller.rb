class StaticPagesController < ApplicationController

  def home
      @recipes = Recipe.all
      @cuisine_list = ["Western", "Indian", "Malay","Chinese"]
  end

  def success
   @user = User.find(current_user.id)
  end

end
