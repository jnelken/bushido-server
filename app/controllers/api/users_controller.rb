class Api::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user ||= User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if !passwords_match
      render json: ["Passwords don't match. Try again"], status: :unprocessable_entity
      return
    end

    if @user.save
      sign_in(@user)
      render :show
    else
      render json: @user.errors.full_messages,  status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      sign_out
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def passwords_match
    params[:user][:password] == params[:user][:retype_password]
  end
end
