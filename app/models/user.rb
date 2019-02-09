class User < ActiveRecord::Base
  has_many :queued_media
  has_many :media, through: :queued_media
end
