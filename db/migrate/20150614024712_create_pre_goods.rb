class CreatePreGoods < ActiveRecord::Migration
  def change
    create_table :pre_goods do |t|
      t.string :name
      t.integer :num
      t.float :price
      t.boolean :is_consume

      t.timestamps null: false
    end
  end
end
