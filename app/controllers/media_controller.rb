class MediaController < ApplicationController

  before_action :set_medium, only: [:show]

  def index
    @media = Medium.all
  end

  def show
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

end
