class CreateCmsArticles < ActiveRecord::Migration
  def change
    create_table :cms_articles do |t|
      t.string :title
      t.text :content
      t.string :image
      t.boolean :is_recommend,default: false
      t.integer :kind,default: 0

      t.timestamps null: false
    end
  end
end
