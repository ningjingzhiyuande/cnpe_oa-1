class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role_id: ["hr","cms_manager","good_manager","consume_good_manger"]

  enum rank_id: {user: 1,chief:100, chairman: 200}
  scope :chairman, -> { where(rank_id: 200) }
  scope :chief, -> { where(rank_id: 100) }
  scope :users, -> { where(rank_id: 1) }
  belongs_to :department,class_name: "Category"#,foreign_key: ""
  #belongs_to :rank,class_name: "Category"#,foreign_key: "item_num"

  has_many :apply_leaves ,class_name: "Leave"

  has_many :entretains
  
  has_many :report_entretains, foreign_key: "reporter_id",class_name: "Entretain"

  before_save :syn_department_num

  def syn_department_num
  	self.department_num = department.item_num
  end


  #enum department: {caigou: 6100, zongguan: 6101,jihua: 6102,\
   #       hetong: 6103,jiyi: 6104, jier: 6105, yikong: 6106, dianqi: 6107,\
  #        jianzao: 6108,zhibao: 6109, xitong: 6110}

  def report_user
  	#department_id: [department_id, 6100],
     User.where({rank_id: 100,department_id: department_id}).select(:id,:name).collect{|u|[u.name,u.id]}
  end

  def last_report_user
  	User.where({rank_id: 200}).select(:id,:name).collect{|u|[u.name,u.id]}
  end
  #判断是不是领导
  def is_leader
  	["chief","chairman"].include? rank_id
  end

  def is_hr?
  	role_id==1
  end

  def residual_annual_days
     days = nj_days 
     return 0 if days<=0
     apply_days = LeaveDetail.apply_and_accept(id).sum(:days).to_f 
     return days - apply_days
  end

  def nj_days
     start_work_at = work_at || Date.today
     diff = (Date.today - start_work_at.to_date).to_i
     
     days = (if diff<366
            (diff/365.0 * 5).to_i
     elsif diff>365 && diff<365*10
     	5
     elsif diff>=365*10 && diff<365*20
     	10
     elsif diff>=365*20
     	15
     end)

    return days

     
  end

  def is_annual
  	return false if shijia_days.to_i==0  	
    apply_days = LeaveDetail.apply_and_accept_bingjia(id).sum(:days).to_f
    return true if apply_days<60
    days = nj_days
    return false if days<=5 && apply_days>=60
    return false if days==10 && apply_days>=90
    return false if days==15 && apply_days>=120
    return true
  end

  def old_year
  	 return Date.today.year-born_at.year if born_at
  	 return 0
  end

  def work_year
  end

  def cj_days
     if gender==1
     	return 10 if old_year>=25
     	return 3 if old_year>=22 && old_year<25
     	return 0
     end
     if gender==2
     	return 10 if old_year>=23
     	return 3 if old_year>=20 
     	return 0
     end

  end

  def shijia_days
  	apply_days = LeaveDetail.apply_and_accept_shijia(id).sum(:days).to_f
  	14-apply_days
  end

  def sangjia_days
  	apply_days = LeaveDetail.apply_and_accept_sangjia(id).sum(:days).to_f
  	3-apply_days
  end
  

end
