class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.integer :user_id
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      #t.integer :kind
      t.integer :status,default: 0
      t.decimal :total_days, precision: 5, scale: 1
      t.text :info
      t.string :image
      t.integer :reporter1_id  #处长审批
      t.integer :reporter2_id  #主任审批

      t.timestamps null: false
    end
    add_index :leaves,:user_id
  end
end
