class AddCommenterInUserComment < ActiveRecord::Migration[7.1]
  def change
    add_column :user_comments, :commenter_id, :integer
  end
end
