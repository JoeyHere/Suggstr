class AddColumnPriorityToQueuedMedia < ActiveRecord::Migration
  def change
    add_column :queued_media, :priority_score, :float
  end
end
