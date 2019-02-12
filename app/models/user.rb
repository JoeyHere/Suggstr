class User < ActiveRecord::Base
  has_many :queued_media
  has_many :media, through: :queued_media
  has_many :rating_records

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :password, presence: true



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

  def self.password_harvester
    self.all.map do |user|
      puts "#{user.name} - #{user.password}"
    end 
  end 


end
