class Leave < ActiveRecord::Base
   has_many :leave_details
   accepts_nested_attributes_for :leave_details, allow_destroy: true

   mount_uploader :image, AttacheUploader

   made_approve need_second_approve_method: "days_more_two"
 
   belongs_to :applicant, class_name: "User",:foreign_key=>"user_id"
   belongs_to :chief, class_name: "User"  ,:foreign_key=>"reporter1_id"
   belongs_to :chairman, class_name: "User"  ,:foreign_key=>"reporter2_id"
   
 
   # 请假大于两天 或者是处长的需要二级审批
   def days_more_two
       total_days.to_f > 2.0 || applicant.rank_id=="chief"
   end

   def leave_days(kind)
   	  return leave_details.find_by(kind: LeaveDetail.kinds[kind]).try(:days).to_f rescue 0
   end
   def self.pass_leaves
   	  where("status=? or status=?",statuses["last_acceptting"],statuses["leader_agree"])
   end
  
   
    #发送test邮件
   def send_test_mail
       LeaveMailer.approve_email(self).deliver
   end

    def has_approved
    	status=="acceptting"
    end

   def is_reporter?(user_id)
    	reporter1_id==user_id
    end


    def is_last_reporter?(user_id)
      reporter2_id==user_id
    end

end
