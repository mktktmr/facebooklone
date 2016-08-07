class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recepient_id
      t.string :content, null: false

      t.timestamps null: false
    end

    add_index :messages, :sender_id
    add_index :messages, :recepient_id
  end
end
