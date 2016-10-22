class User < ApplicationRecord
  has_many :shouts
  has_many :sent_shouts, class_name: 'Shout', foreign_key: :shouter_id

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :profile_image_url, presence: true
end
