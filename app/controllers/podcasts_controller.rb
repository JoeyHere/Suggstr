class PodcastsController < ApplicationController


 def index
    @podcasts = Medium.podcasts
 end 


end