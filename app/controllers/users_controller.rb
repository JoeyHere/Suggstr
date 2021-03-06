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
         
          flash[:danger] = @user.errors.full_messages

          redirect_to new_user_path
      end
  end

  def dashboard
    if logged_in?
      if params[:q] && params[:q] != ""
        @searched = Tag.find_by(name: params[:q].downcase)
        @media = current_user.media.select{|m| m.tags.include?(@searched)}
      else
        @media = @user.sub_list("Top List")
        @sub = "Top List"
      end
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
    @medium = Medium.find(params[:medium_id])
  end

  def rated
    RatingRecord.create(user_id: params[:user_id], medium_id: params[:medium_id], rated_score: params[:category])
    redirect_to user_history_path
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
