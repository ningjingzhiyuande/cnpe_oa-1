class CreateCmsHomes < ActiveRecord::Migration
  def change
    create_table :cms_homes do |t|
      t.string :title
      t.string :url
      t.string :image
      t.integer :kind
      t.text :content

      t.timestamps null: false
    end
  end
end
