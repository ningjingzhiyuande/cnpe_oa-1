class AddFieldToLevelDetail < ActiveRecord::Migration
  def change
  	add_column :leave_details,:leave_year,:integer,default: Date.today.year
  	add_column :leave_details,:vacation_year,:integer,default: Date.today.year
  end
end
