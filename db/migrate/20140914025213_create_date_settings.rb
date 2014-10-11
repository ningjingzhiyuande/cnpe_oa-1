class CreateDateSettings < ActiveRecord::Migration
  def change
    create_table :date_settings do |t|
      t.integer :user_id
      t.integer :year
      t.integer :work_status,default: 0
      t.string :data
      t.timestamps null: false
    end
    add_index :date_settings,:year
    add_index :date_settings,:work_status
  end
end
