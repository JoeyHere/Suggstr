class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :medium_id
      t.integer :sender_id
      t.integer :receiver_id
      t.string :message

      t.timestamps null: false
    end
  end
end
