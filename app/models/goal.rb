class Goal < ApplicationRecord
  belongs_to :user

  def private_goal=(private_value)
    self.private = private_value == "on"
  end
end
