class Reaction < ApplicationRecord
  belongs_to :shout

  validates :emoji, presence: true
end
