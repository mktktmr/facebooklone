class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :picture
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
