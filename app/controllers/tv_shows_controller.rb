class TvShowsController < ApplicationController


 def index
    @tv_shows = Medium.tv_shows
 end

 def show
 end 


end