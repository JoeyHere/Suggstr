class VideoGamesController < ApplicationController

 def index
    @video_games = Medium.video_games
 end

 def show
 end 


end
