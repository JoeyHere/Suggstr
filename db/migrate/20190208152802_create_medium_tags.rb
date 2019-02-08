class CreateMediumTags < ActiveRecord::Migration
  def change
    create_table :medium_tags do |t|
      t.integer :medium_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
