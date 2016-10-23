class ShoutUser < ApplicationRecord
  belongs_to :user
  belongs_to :shout
end
