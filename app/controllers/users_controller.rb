class UsersController < ApplicationController
    before_action :find_user, only: [:show]

    def new
        @user = User.new
    end 

    def create 
        @user = User.create(user_params)
        if @user.valid?
            log_in @user
            redirect_to user_path(@user)
        else
            flash[:errors] = @user.errors.full_messages

            redirect_to '/'
        end 

        def show

        end 
    end 


    private

    def user_params
        params.require(:user).permit(
            :name,
            :password,
        )
    end 

    def find_user
        @user = User.find(params[:id])
    end 
end
