class CreateExamines < ActiveRecord::Migration
  def change
    create_table :examines do |t|
       
      t.integer :item_id
      t.string :item_type
      t.integer :review_id
      t.integer :user_id
      t.integer :position,default: 0
      t.integer :status,default: 0
      t.boolean :current_review,default: 0


      t.timestamps null: false
    end
  end
end
