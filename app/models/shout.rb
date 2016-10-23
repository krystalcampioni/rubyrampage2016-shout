class Shout < ApplicationRecord
  belongs_to :shouter, class_name: 'User'
  has_many :shout_users
  has_many :users, through: :shout_users

  validates :message, presence: true

  after_create :associate_users

  def identified_users
    message.scan(/@[a-zA-Z_]*/)
  end

  private

  def associate_users
    identified_users.each do |nickname|
      user = User.fetch_by_nickname(nickname)
      shout_users.find_or_create_by(user_id: user.id)
    end
  end
end
