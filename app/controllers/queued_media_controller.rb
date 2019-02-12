class QueuedMediaController < ApplicationController

  before_action :find_queued_medium, only: [:destroy]
  before_action :find_user, only: [:destroy]

  def destroy
    @queued_medium.destroy
    redirect_to user_path(@user)
  end

  private

  def find_queued_medium
    @queued_medium = QueuedMedium.find(params[:id])
  end

  def find_user
      @user = current_user
  end

end
