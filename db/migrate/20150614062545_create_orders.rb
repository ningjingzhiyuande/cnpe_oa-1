class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_key
      t.string :name
      t.integer :pre_good_id
      t.integer :num
      t.float :price
      t.integer :user_id
      t.integer :status,default: 0
      t.timestamps null: false
    end

    add_index :orders,:order_key
    add_index :orders,:status
  end
end
