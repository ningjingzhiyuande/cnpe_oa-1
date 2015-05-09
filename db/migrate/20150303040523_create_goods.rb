class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.integer :user_id
      t.text :descript
      t.boolean :is_consume
      t.boolean :is_return
      t.integer :loan_num,default: 0
      t.integer :stock_num,default: 0
      t.integer :apply_num,default: 0
      

      t.timestamps null: false
    end
    add_index :goods,:is_consume
    add_index :goods,:user_id
  end
end
