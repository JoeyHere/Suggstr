class Medium < ActiveRecord::Base
  has_many :medium_tags
  has_many :tags, through: :medium_tags
  has_many :queued_media
  has_many :users, through: :queued_media
  belongs_to :type



end
