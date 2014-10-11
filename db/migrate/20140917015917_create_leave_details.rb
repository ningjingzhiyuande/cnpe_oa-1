class CreateLeaveDetails < ActiveRecord::Migration
  def change
    create_table :leave_details do |t|
      t.integer :user_id
      t.integer :leave_id
      t.string :data
      t.decimal :days, precision: 5, scale: 1
      t.datetime :start_at
      t.datetime :end_at
      t.integer :kind
      t.integer :status,default: 0
      t.timestamps null: false
    end
    add_index :leave_details,:user_id
    add_index :leave_details,:leave_id
    add_index :leave_details,:kind
  end
end
