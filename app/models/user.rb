class User < ApplicationRecord
  has_many :shouts
  has_many :sent_shouts, class_name: 'Shout', foreign_key: :shouter_id

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :profile_image_url, presence: true

  def self.find_or_create_from_auth_hash(twitter_hash)
    user = where(nickname: twitter_hash[:info][:nickname]).first_or_initialize
    user.update(name: twitter_hash[:info][:name],
                profile_image_url: twitter_hash[:info][:image])
    user
  end
end
