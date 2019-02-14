class Suggestion < ActiveRecord::Base

  belongs_to :sender, class_name: "User", primary_key: "sender_id"
  belongs_to :receiver, class_name: "User", primary_key: "receiver_id"
  belongs_to :medium

  def sender_object
    User.find(self.sender_id)
  end

  def receiver_object
    User.find(self.receiver_id)
  end

end
