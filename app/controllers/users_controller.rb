class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
      @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
   @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :email, :contactno, :birthdate)
    end
end
