class User < ApplicationRecord
  has_many :sent_shouts, class_name: 'Shout', foreign_key: :shouter_id
  has_many :shout_users
  has_many :shouts, through: :shout_users

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
  validates :profile_image_url, presence: true

  def to_param
    nickname
  end

  def self.fetch_by_nickname(nickname)
    find_by('lower(nickname) = ?', nickname.downcase) || create!(UserFromTwitter.new(nickname).attributes)
  end

  def self.find_or_create_from_auth_hash(twitter_hash)
    user = where(nickname: twitter_hash[:info][:nickname]).first_or_initialize
    user.update(name: twitter_hash[:info][:name],
                profile_image_url: twitter_hash[:info][:image])
    user
  end
end
