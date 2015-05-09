class CreateCmsDangquns < ActiveRecord::Migration
  def change
    create_table :cms_dangquns do |t|
      t.string :title
      t.string :document
      t.boolean :is_recommend,default: false

      t.timestamps null: false
    end
  end
end
