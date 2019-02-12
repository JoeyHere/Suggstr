class CreateTableRatingRecords < ActiveRecord::Migration
  def change
    create_table :rating_records do |t|
      t.integer :user_id
      t.integer :medium_id
      t.string :rated_score
    end
  end
end
