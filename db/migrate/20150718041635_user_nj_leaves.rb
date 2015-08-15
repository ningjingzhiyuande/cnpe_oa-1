class UserNjLeaves < ActiveRecord::Migration
  def change
  	  create_table :user_nj_leaves do |t|
      t.integer :user_id
      t.integer :total_days
      t.integer :leave_days
      t.integer :remain_days
      t.integer :year
      t.timestamps
    end
  end
end
