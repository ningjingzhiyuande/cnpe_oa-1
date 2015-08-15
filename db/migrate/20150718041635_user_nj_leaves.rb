class UserNjLeaves < ActiveRecord::Migration
  def change
  	  create_table :user_nj_leaves do |t|
      t.integer :user_id
      t.integer :total_days #总假期
      t.integer :leave_days  #请了多少天的假
      t.integer :remain_days #剩余多少天
      t.integer :year  #每年的年份
      t.timestamps
    end
  end
end
