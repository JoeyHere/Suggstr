class MediaController < ApplicationController

  before_action :set_medium, only: [:show]

  def index
    @media = Medium.all
  end

  def show
  end

  def new
    @medium = Medium.new
  end

  def create
    new_medium = Medium.new(medium_params)
    redirect_to new_medium
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

  def medium_params
    params.require(:medium).permit(:title, :type_id)
  end

end
