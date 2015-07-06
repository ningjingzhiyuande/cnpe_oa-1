class AddDepartmentNumToUser < ActiveRecord::Migration
  def change
  	add_column :users,:department_num,:string
  	add_index :users,:department_num
  end
end
