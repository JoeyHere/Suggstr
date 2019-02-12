class User < ActiveRecord::Base
  has_many :queued_media
  has_many :media, through: :queued_media

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :password, presence: true


  def sorted_queued_list
    self.reload
    sorted_queued_list = []
    queue_list = self.queued_media.sort_by {|m| 0-m.priority_score}
    queue_list.each do |ql|
      sorted_queued_list << Medium.find(ql.medium_id)
    end
    return sorted_queued_list
  end

  def move_medium_up(medium_up)
    queued_list = self.sorted_queued_list
    current_spot = queued_list.index(medium_up)
    medium_down = queued_list[current_spot-1]
    old_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_up.id)
    new_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_down.id)
    old_priority_score = old_queued_medium.priority_score
    old_queued_medium.update(priority_score: new_queued_medium.priority_score)
    new_queued_medium.update(priority_score: old_priority_score)
  end

  def move_medium_down(medium_down)
    queued_list = self.sorted_queued_list
    current_spot = queued_list.index(medium_down)
    medium_up = queued_list[current_spot+1]
    old_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_down.id)
    new_queued_medium = QueuedMedium.find_by(user_id:self.id, medium_id:medium_up.id)
    old_priority_score = old_queued_medium.priority_score
    old_queued_medium.update(priority_score: new_queued_medium.priority_score)
    new_queued_medium.update(priority_score: old_priority_score)
  end

  def self.password_harvester
    self.all.map do |user|
      puts "#{user.name} - #{user.password}"
    end 
  end 


end
