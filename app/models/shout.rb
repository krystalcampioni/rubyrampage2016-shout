class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :shouter, class_name: 'User'

  validates :emoji_badge, :message, presence: true
end
