class CreateLeaveStatistics < ActiveRecord::Migration
  def change
    create_table :leave_statistics do |t|
      t.integer :user_id
      t.integer :leave_detail_id
      t.integer :kind
      t.integer :month
      t.integer :year
      t.string :data
      t.decimal :total_days, precision: 5, scale: 1

      t.timestamps null: false
    end
  end
end
