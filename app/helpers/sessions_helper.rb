module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    def logged_in?
    !current_user.nil?
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

     def authorized?
        if !logged_in?
          flash.now[:errors] = ["you must be logged in to view that"]
          redirect_to login_path and return  # double redirect safeguarduser
        end
     end

    def authorized_for(target_user_id)
      if current_user.id != target_user_id.to_i && current_user.admin != true
        flash.now[:errors] = ["You cannot view a page that does not belong to you!"]
        redirect_to signup_path
      end
    end



end
