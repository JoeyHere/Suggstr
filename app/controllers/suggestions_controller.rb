class SuggestionsController < ApplicationController

  def new
    @suggestion = Suggestion.new
    @medium = Medium.find(params[:id])
  end

  def create

    @suggestion = Suggestion.new(suggestion_params)
    receiver = User.find_by(name: params[:user][:name])
    if receiver && receiver != current_user
      @suggestion.update(receiver_id: receiver.id, sender_id: current_user.id)
      @suggestion.save
      flash[:message] = "#{@suggestion.receiver_object.name} has received your suggestion."
      redirect_to dashboard_path
    else
      flash[:message] = "you cannot suggest media to yourself!"
      redirect_to dashboard_path
    end
  end

  def show
    @suggestion = Suggestion.find(params[:id])
    @queued_medium = QueuedMedium.new(user_id: current_user)
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy
    flash[:message] = "Suggestion removed."
    redirect_to user_suggestions_path(current_user)
  end


  private

  def suggestion_params
    params.require(:suggestion).permit(:message, :medium_id)
  end

end
