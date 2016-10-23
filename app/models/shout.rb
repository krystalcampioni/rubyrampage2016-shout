class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :shouter, class_name: 'User'

  validates :message, presence: true

  def identified_users
    message.scan(/@[a-zA-Z_]*/)
  end
end
