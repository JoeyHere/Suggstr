class RatingRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :medium


  def self.categories
    return ["Good", "Average", "Bad"]
  end

end
