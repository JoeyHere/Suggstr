class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.boolean :rating
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
