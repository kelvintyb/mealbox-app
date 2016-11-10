class StaticPagesController < ApplicationController


  def home
      @recipes = Recipe.all
  end






end
