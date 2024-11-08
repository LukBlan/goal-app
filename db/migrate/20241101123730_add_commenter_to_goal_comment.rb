class AddCommenterToGoalComment < ActiveRecord::Migration[7.1]
  def change
    add_column :goal_comments, :commenter_id, :integer
  end
end
