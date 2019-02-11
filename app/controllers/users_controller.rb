class UsersController < ApplicationController

  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def new
      @user = User.new
  end

  def create

      @user = User.find_or_create_by(user_params)
      if @user.valid?
          redirect_to user_path(@user)
      else
          flash[:errors] = @user.errors.full_messages

          redirect_to '/'
      end 
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

  def user_params
      params.require(:user).permit(
          :name,
          :password
      )
  end

  def find_user
      @user = User.find(params[:id])
  end
end
