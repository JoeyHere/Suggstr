class Medium < ActiveRecord::Base
  has_many :medium_tags
  has_many :tags, through: :medium_tags
  has_many :queued_media
  has_many :users, through: :queued_media
  belongs_to :type


    def self.podcasts
      podcasts = self.all.select do |medium|
        medium.type.name == "Podcast"
        end
        podcasts.sort_by do |podcast|
          podcast.title
        end
      end

    def self.movies
        movies = self.all.select do |medium|
          medium.type.name == "Movie"
          end
          movies.sort_by do |movie|
            movie.title
          end
        end

    def self.tv_shows
          tv_shows = self.all.select do |medium|
            medium.type.name == "TV Show"
            end
            tv_shows.sort_by do |show|
              show.title
            end 
          end

    def self.video_games
          video_games = self.all.select do |medium|
            medium.type.name == "Video Game"
            end
            video_games.sort_by do |game|
              game.title
            end
          end

end
