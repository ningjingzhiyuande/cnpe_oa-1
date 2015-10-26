class ChangeEntretains < ActiveRecord::Migration
  def up
    Entretain.translate_legency_fee!

    change_column :entretains, :fee, :integer, default: 0 
    add_column :entretains, :entertained_level, :string #被宴请方层级
    add_column :entretains, :entertained_num, :integer, default: 0  #被宴请人数
  end

  def down
    remove_column :entretains, :entertained_num
    remove_column :entretains, :entertained_level
    change_column :entretains, :fee, :string
  end
end
