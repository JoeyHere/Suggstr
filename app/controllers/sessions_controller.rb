class SessionsController < ApplicationController

  def new
  end

  def create
    
    user = User.find_by(username: params[:session][:username])
     if user && user.authenticate(params[:session][:password])
      # log_in method in app/helpers/session_helper/rb
      log_in user
      redirect_to dashboard_path
     else

      flash[:danger] = ["Login information not found. Please try again or sign up"]

      render 'new'
    end
  end

  def destroy
    log_out
    # log_out method in app/helpers/session_helper/rb
    redirect_to root_url
  end
end
