class MoviesController < ApplicationController


 def index
    @movies = Medium.movies
 end

 def show
 end 


end