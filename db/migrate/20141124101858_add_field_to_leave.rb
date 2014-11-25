class AddFieldToLeave < ActiveRecord::Migration
  def change
  	add_column :leaves, :admin_modify, :boolean,default: false
  end
end
