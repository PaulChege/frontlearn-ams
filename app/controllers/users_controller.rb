# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to users_path, notice: 'User updated successfully.'
    else
      render :new
    end
  end

  def destroy
    @user.delete
    redirect_to users_path, notice: 'User deleted successfully.'
  end

  private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
    end
end
