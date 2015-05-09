class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :applier_id
      t.integer :item_id
      t.string :item_type
      t.integer :parent_id
      t.integer :position
      t.integer :user_id
      t.string  :kind

      t.timestamps null: false
    end
    add_index :reviews,[:item_id,:item_type]
    add_index :reviews,[:item_id,:item_type,:kind]
    add_index :reviews,:user_id
    

  end
end
