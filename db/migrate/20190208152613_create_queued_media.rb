class CreateQueuedMedia < ActiveRecord::Migration
  def change
    create_table :queued_media do |t|
      t.integer :medium_id
      t.integer :user_id
      t.integer :rating
      t.boolean :completed
      t.timestamps null: false
    end
  end
end
