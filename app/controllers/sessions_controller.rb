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
<<<<<<< HEAD
      flash.now[:danger] = ["Login information not found. Please try again or sign up"]
=======
      flash.now[:errors] = ["Login information not found. Please try again or sign up"]
>>>>>>> 45022708dd8a1bd4e8ef9e34dd9e87825e672da1
      render 'new'
    end
  end

  def destroy
    log_out
    # log_out method in app/helpers/session_helper/rb
    redirect_to root_url
  end
end
