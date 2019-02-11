class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @media = @user.sorted_queued_list
  end

  def move_up
    @user = User.find(params[:user_id])
    @medium = Medium.find(params[:medium_id])
    @user.move_medium_up(@medium)
    #byebug
    redirect_to user_path(@user)
  end

  def move_down
    @user = User.find(params[:user_id])
    @medium = Medium.find(params[:medium_id])
    @user.move_medium_down(@medium)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


end
