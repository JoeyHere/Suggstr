class QueuedMedium < ActiveRecord::Base
  belongs_to :medium
  belongs_to :user

  def initialize(args)
    super

    # initialize priority score based on order of creation (higher score when created later)
    user = User.find(args[:user_id])
    if user.queued_media == nil || user.queued_media == []
      highest_score = 0
    else
      highest_score = user.queued_media.max_by{|qm| qm.priority_score}.priority_score
    end
    self.priority_score = highest_score + 1
  end

end
