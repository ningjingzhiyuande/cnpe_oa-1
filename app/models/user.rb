class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum rank_id: {user: 1,chief:100, chairman: 200}
  belongs_to :department,class_name: "Category"#,foreign_key: ""
  #belongs_to :rank,class_name: "Category"#,foreign_key: "item_num"

  has_many :apply_leaves ,class_name: "Leave"


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

     apply_days = Leave.apply_and_accept(id).sum(:total_days).to_f 
     return days - apply_days

     
  end
  

end
