class AddLastYearLeaveToLeaveDetail < ActiveRecord::Migration
  def change
  	add_column :leave_details,:last_year_days,:integer,default: 0 #请假中 去年年假休几天
  	add_column :leave_details,:this_year_days,:integer,default: 0
  end
end
