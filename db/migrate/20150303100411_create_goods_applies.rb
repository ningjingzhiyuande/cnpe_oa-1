class CreateGoodsApplies < ActiveRecord::Migration
  def change
    create_table :goods_applies do |t|
      t.integer :good_id
      t.integer :user_id
      t.integer :apply_num
      t.text :apply_info
      t.string :reviewer_ids
      t.integer :current_reviewer_id
      t.boolean :is_review_over,default: false
     # t.integer :review_id     
      t.integer :status,default: 0

      t.timestamps null: false
    end
    add_index :goods_applies,:good_id
    #add_index :goods_applies,:review_id
    add_index :goods_applies,:status
    add_index :goods_applies,:user_id


  end
end
