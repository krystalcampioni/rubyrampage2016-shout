class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :shouter, class_name: 'User'
end
