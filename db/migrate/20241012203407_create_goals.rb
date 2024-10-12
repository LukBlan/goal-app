class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.boolean :private, null: false
      t.index :user_id
    end
  end
end
