class QueuedMedium < ActiveRecord::Base
  belongs_to :medium
  belongs_to :user
end
