class ChangeEmailFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :text, null: true
  end
end
