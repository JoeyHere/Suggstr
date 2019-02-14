class QueuedMediaController < ApplicationController

  before_action :find_queued_medium, only: [:destroy]
  before_action :find_user, only: [:destroy]

  def create
    byebug
    if !QueuedMedium.find_by(user_id: current_user.id, medium_id: params[:queued_medium][:medium_id])
      @queued_medium = QueuedMedium.new(user_id: current_user.id)
      @queued_medium.update(queued_medium_params)
      flash[:message] = "#{@queued_medium.medium.title} has been added to your que."
    else
      flash[:message] = "This is already in your que."
    end

    current_user.received_suggestions.each do |sug|
      sug.destroy if sug && sug.medium_id == params[:queued_medium][:medium_id].to_i
    end

    redirect_to dashboard_path
  end

  def destroy
    @queued_medium.destroy
    redirect_to dashboard_path
  end

  private

  def find_queued_medium
    @queued_medium = QueuedMedium.find(params[:id])
  end

  def find_user
      @user = current_user
  end

  def queued_medium_params
    params.require(:queued_medium).permit(:medium_id)
  end

end
