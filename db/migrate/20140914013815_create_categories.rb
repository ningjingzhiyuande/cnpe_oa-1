class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :kind,default: 0
      t.integer :user_id
      t.string :item_num
      t.string :name
      t.string :info
      t.string :position
      t.integer :status,default: 0

      t.timestamps null: false
    end
    add_index :categories, :kind
    add_index :categories,:item_num
   
    Category.kinds.each do |k,v|
  	  if k == "dept"
  	  	hash ={"采购部"=>  6100, "综合管理处"=>  6101,"计划处"=>  6102,\
          "合同管理处"=>  6103,"机械一处"=>  6104, "机械二处"=>  6105, "仪控处"=>  6106, "电气处"=>  6107,\
          "监造处"=>  6108,"质量保证处"=>  6109, "系统设备及大宗材料处"=>  6110}
          hash.each do |key,value|
          	Category.create({item_num: value,name: key,kind: k})
          end
  	  end

  	  if  k == "rank"
         h = {"员工"=> 1,"处长"=>100, "主任"=> 200}
         h.each do |k1,v1|
         	c = Category.create({name: k1,kind: k})
         	c.item_num = c.id 
         	c.save

         end
  	  end
    end

  end

end
