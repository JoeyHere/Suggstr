class Tag < ActiveRecord::Base
  has_many :medium_tags
  has_many :media, through: :medium_tags
end
