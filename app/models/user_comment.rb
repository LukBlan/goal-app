class UserComment < ApplicationRecord
  validates :comment, presence: true
end
