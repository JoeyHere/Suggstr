class SuggestionsController < ApplicationController

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.receiver_id != current_user.id
    @suggestion.update(sender_id: current_user.id)
    @suggestion.save
    redirect_to dashboard_path
    else
      flash[:error] = "you cannot suggest media to yourself!"
        render :new
      end
  end

  def show
    @suggestion = Suggestion.find(params[:id])
  end


  private

  def suggestion_params
    params.require(:suggestion).permit(:medium_id, :receiver_id, :message)
  end

end
