class CreateUserComment < ActiveRecord::Migration[7.1]
  def change
    create_table :user_comments do |t|
      t.integer :user_id, null: false
      t.string :comment, null: false
    end
  end
end
