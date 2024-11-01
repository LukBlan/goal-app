class CreateGoalComment < ActiveRecord::Migration[7.1]
  def change
    create_table :goal_comments do |t|
      t.string :comment, null: false
      t.integer :goal_id, null: false
    end
  end
end
