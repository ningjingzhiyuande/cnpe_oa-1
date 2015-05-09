class CreateLoanGoods < ActiveRecord::Migration
  def change
    create_table :loan_goods do |t|
      t.integer :good_id
      t.integer :user_id
      t.integer :apply_num
      t.datetime :start_at
      t.datetime :end_at
      t.text :loan_info
      t.string :reviewer_ids
      t.integer :current_reviewer_id
      t.boolean :is_review_over,default: false
     # t.integer :review_id     
      t.boolean :is_consume
     
       t.integer :status,default: 0

      t.timestamps null: false
    end
  end
end
