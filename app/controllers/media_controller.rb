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
    @medium = Medium.find_or_create_by(medium_params)

    if !@medium.valid?
      flash[:errors] = @medium.errors.full_messages
      render :new
    else
      tags = params[:tags].split(",").map {|tag| tag.downcase}

      if tags.length > 0
        tags.each do |tag|
          add_tag = Tag.find_or_create_by(name: tag)
          @medium.tags << add_tag if !@medium.tags.include?(add_tag)
        end
      end

      @medium.save
      QueuedMedium.create(user_id:current_user.id, medium_id:@medium.id)
      #current_user.media << @medium
      redirect_to @medium
    end
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

  def medium_params
    params.require(:medium).permit(:title, :type_id)
  end

end
