class AddFieldToLeaveDetail < ActiveRecord::Migration
  def change
  	 add_column :leave_details, :start_at_half_day, :integer
  	 add_column :leave_details, :end_at_half_day, :integer
  end
end
