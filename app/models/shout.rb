class Shout < ApplicationRecord
  belongs_to :shouter, class_name: 'User'
  has_and_belongs_to_many :users

  validates :message, presence: true

  after_create :associate_users

  def identified_users
    message.scan(/@[a-zA-Z_]*/)
  end

  private

  def associate_users
    identified_users.each do |nickname|
      users << User.fetch_by_nickname(nickname)
    end
  end
end
