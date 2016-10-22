class User < ApplicationRecord
  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :profile_image_url, presence: true
end
