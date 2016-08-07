class Topic < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates :content, presence: true

  mount_uploader :picture, PictureUploader
end
