class AddFieldToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :born_at, :date
  end
end
