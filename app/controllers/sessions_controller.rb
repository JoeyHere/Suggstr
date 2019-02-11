class SessionsController < ApplicationController
   
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
     if user && params[:session][:password] == user.password
      # log_out method in app/helpers/session_helper/rb
      log_in user
      redirect_to user
     else
      flash.now[:danger] = "Login information not found. Please try again or sign up"
      render 'new'
    end
  end

  def destroy
    log_out
    # log_out method in app/helpers/session_helper/rb
    redirect_to root_url
 
  end

end
