class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :topics
  has_many :comments

  def email_required?
    (authentications.empty? || !email.blank?) && super
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email || '',
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
binding.pry
    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email || '',
          password: Devise.friendly_token[0, 20],
      )
      # user.skip_confirmation! # TODO: deviseのconfirmableを利用する場合にコメントアウトを外す
      user.save
    end
    user
  end
end
