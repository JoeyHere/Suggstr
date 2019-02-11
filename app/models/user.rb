class User < ActiveRecord::Base
  has_many :queued_media
  has_many :media, through: :queued_media
  validates :name, presence: true 
  validates :name, uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
