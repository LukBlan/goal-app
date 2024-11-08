class GoalComment < ApplicationRecord
  validates :comment, presence: true
end
