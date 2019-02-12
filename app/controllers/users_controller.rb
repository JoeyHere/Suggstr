class UsersController < ApplicationController

  before_action :find_user, only: [:show, :move_up, :move_down, :completed, :rated]

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
    @completed_media = @user.completed_queued_list
  end

  def move_up
    @medium = Medium.find(params[:medium_id])
    @user.move_medium_up(@medium)
    redirect_to user_path(@user)
  end

  def move_down
    @medium = Medium.find(params[:medium_id])
    @user.move_medium_down(@medium)
    redirect_to user_path(@user)
  end

  def completed
    @queued_medium = QueuedMedium.find_by(medium_id: params[:medium_id], user_id: params[:user_id])
    @queued_medium.update(completed:true)
  end

  def rated
    RatingRecord.create(user_id: params[:user_id], medium_id: params[:medium_id], rated_score: params[:category])
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
      @user = current_user
  end
end
