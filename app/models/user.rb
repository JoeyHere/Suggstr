class User < ActiveRecord::Base
  has_many :queued_media
  has_many :media, through: :queued_media
  has_many :rating_records
  has_many :sent_suggestions, class_name: "Suggestion", foreign_key: "sender_id"
  has_many :received_suggestions, class_name: "Suggestion", foreign_key: "receiver_id"



  validates :name, presence: true
  validates :username, uniqueness: { case_sensitive: false }, presence: {message: "must be added to send and receive suggstns"}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "must be valid address" }
  validates :email, uniqueness: { case_sensitive: false, message: "can't be added, please try again" }
  has_secure_password

  #somehow Type.all does not work in the sub function for activerecord, how weird. Now manually writing this
  @@types = ["Book", "TV Show", "Movie", "Video Game", "Podcast"]

  #select top 5 if top list, otherwise select list of the category
  def sub_list(category)
    if category == "Top List"
      top_x = 5
      sub_list = []
      @@types.each do |type|
        if category_list(type).size >= 5
          sub_list << category_list(type)[0..top_x-1]
        else
          sub_list << category_list(type)
        end
      end
    else
      sub_category = category.sub("-", " ")[0..category.size-2]
      sub_list = category_list(sub_category)
    end
    return sub_list.flatten
  end

  def category_list(category)
    full_list = self.sorted_queued_list
    return full_list.select{|m| m.type.name == category}
  end

  def sorted_queued_list
    self.reload
    sorted_queued_list = []
    queue_list = self.queued_media.select{|m| m.completed != true}.sort_by {|m| 0-m.priority_score}
    queue_list.each do |ql|
      sorted_queued_list << Medium.find(ql.medium_id)
    end
    return sorted_queued_list
  end

  def move_medium_up(medium_up)
    queued_list = self.sorted_queued_list
    current_spot = queued_list.index(medium_up)

    #ensure the top of the list cannot be moved even further
    if current_spot != 0
      medium_down = queued_list[current_spot-1]
      old_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_up.id)
      new_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_down.id)
      # swap with neighbor
      old_priority_score = old_queued_medium.priority_score
      old_queued_medium.update(priority_score: new_queued_medium.priority_score)
      new_queued_medium.update(priority_score: old_priority_score)
    end
  end


  def move_medium_down(medium_down)
    queued_list = self.sorted_queued_list
    current_spot = queued_list.index(medium_down)
    if current_spot != queued_list.size-1
      medium_up = queued_list[current_spot+1]
      old_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_down.id)
      new_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_up.id)
      old_priority_score = old_queued_medium.priority_score
      old_queued_medium.update(priority_score: new_queued_medium.priority_score)
      new_queued_medium.update(priority_score: old_priority_score)
    end
  end

  def completed_queued_list
    self.reload
    completed_queued_list = []
    queue_list = self.queued_media.select{|m| m.completed == true}
    queue_list.each do |ql|
      completed_queued_list << Medium.find(ql.medium_id)
    end
    return completed_queued_list
  end



end
