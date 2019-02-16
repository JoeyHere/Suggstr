class Medium < ActiveRecord::Base
  has_many :medium_tags
  has_many :tags, through: :medium_tags
  has_many :queued_media
  has_many :users, through: :queued_media
  belongs_to :type
  has_many :suggestions
  has_many :rating_records

  validates :title, presence: true


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

    def rating_history
      self.reload
      rating_history = {}
      #number of people rated
      total = self.rating_records.size
      RatingRecord.categories.each do |category|
        if total == 0
          rating_history[category] = nil
        else
          rating_history[category] = self.rating_records.select{|rr| rr.rated_score == category}.count.to_f/total
        end
      end
      return rating_history
    end

    def good_score
      if !!self.rating_history[RatingRecord.categories.first]
        return self.rating_history[RatingRecord.categories.first]
      else
        return 0
      end
    end

    def avg_score
      if !self.rating_history.values.include?(nil)
        return self.rating_history[RatingRecord.categories.first] + (self.rating_history[RatingRecord.categories.second])*0.6 + (self.rating_history[RatingRecord.categories.last])*0.2
      else
        return 0
      end
    end

    def title_with_type
      "#{self.title} (#{self.type.name})"
    end

    def self.top_rated(x)
      Medium.all.sort_by{|m| m.avg_score}.reverse[0..x-1]
    end

    def self.most_popular(x)
      Medium.all.sort_by{|m| m.queued_media.count}.reverse[0..x-1]
    end

end
