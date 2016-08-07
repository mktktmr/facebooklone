class Message < ActiveRecord::Base
  belongs_to :sender, class_name: :User, foreign_key: :sender_id
  belongs_to :recepient, class_name: :User, foreign_key: :sender_id
end
