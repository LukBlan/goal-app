class Goal < ApplicationRecord
  belongs_to :user

  has_many :comments, foreign_key: :goal_id, class_name: "GoalComment"

  def private_goal=(private_value)
    self.private = private_value == "on"
  end
end
