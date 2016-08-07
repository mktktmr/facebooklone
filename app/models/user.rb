class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable

  mount_uploader :avatar, AvatarUploader

  has_many :topics
  has_many :comments

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :sender, class_name: :Message, foreign_key: :sender_id
  has_many :recepient, class_name: :Message, foreign_key: :sender_id

  def email_required?
    super && provider.blank?
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def each_follow_users
    users = []
    followers.each do |f|
      f.followers.each do |ff|
        users.append f if ff.id == id
      end
    end
    users
  end

  def each_follow_user_ids
    ids = []
    followers.each do |f|
      f.followers.ids.each do |ffid|
        ids.append f.id if ffid == id
      end
    end
    ids
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email,
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      # 確認メールの処理を飛ばす
      # user.skip_confirmation! # TODO: deviseのconfirmableを利用する場合にコメントアウトを外す

      user.save(validate: false)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20],
      )
      # user.skip_confirmation! # TODO: deviseのconfirmableを利用する場合にコメントアウトを外す
      user.save
    end
    user
  end
=begin
  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end
=end
end
