class CreateCmsDepartments < ActiveRecord::Migration
  def change
    create_table :cms_departments do |t|
      t.string :title
      t.text :content
      t.boolean :is_recommend,default: false
      t.string :image
      t.integer :kind

      t.timestamps null: false
    end
    name = ["部门介绍","组织结构","业务范围","人员信息","团队建设","关于我们"]
    CmsDepartment.kinds.each do |k,v|
        CmsDepartment.create(title: name[v],kind: v)
    end
  end
end
