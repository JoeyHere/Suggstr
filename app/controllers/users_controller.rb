class UsersController < ApplicationController

  before_action :find_current_user, only: [:move_up, :move_down, :completed, :rated, :history, :dashboard, :sub_list, :suggestions]
   before_action :require_login, only: [:dashboard, :move_up, :move_down, :completed, :rated, :history, :sub_list, :suggestions]

  def index
    @users = User.all
  end

  def new
      @user = User.new
  end

  def create
      @user = User.create(user_params)
      if @user.valid?
        log_in @user
          redirect_to dashboard_path
      else
          flash[:errors] = @user.errors.full_messages

          render new_user_path
      end
  end

  def dashboard
    if logged_in?
      @media = @user.sub_list("Top List")
      @sub = "Top List"
    else
      redirect_to login_path
    end
  end

  def sub_list
    if logged_in?
      @media = @user.sub_list(params[:sub])
      @sub = params[:sub]
      render 'dashboard'
    else
      redirect_to login_path
    end
  end

  def move_up
    @medium = Medium.find(params[:medium_id])
    category = @medium.type.name
    @user.move_medium_up(@medium)
    url = "/dashboard/#{category.sub(" ", "-")}s"
    redirect_to url
  end

  def move_down
    @medium = Medium.find(params[:medium_id])
    category = @medium.type.name
    @user.move_medium_down(@medium)
    url = "/dashboard/#{category.sub(" ", "-")}s"
    redirect_to url
  end

  def completed
    @queued_medium = QueuedMedium.find_by(medium_id: params[:medium_id], user_id: params[:user_id])
    @queued_medium.update(completed:true)
  end

  def rated
    RatingRecord.create(user_id: params[:user_id], medium_id: params[:medium_id], rated_score: params[:category])
    redirect_to dashboard_path
  end

  def history
    authorized_for((params[:user_id]))
    @media = @user.sorted_queued_list
    @completed_media = @user.completed_queued_list
  end

  def suggestions
    authorized_for((params[:id]))
    @user = User.find(params[:id])
  end


  def show
    @user = User.find(params[:id])
    @media = @user.sorted_queued_list
  end


  private

  def user_params
      params.require(:user).permit(
          :email,
          :name,
          :username,
          :password
      )
  end

  def find_current_user
      @user = current_user
  end

    def require_login
      authorized?
    end

end
