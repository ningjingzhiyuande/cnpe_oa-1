module Approve #:nodoc:
	mattr_writer :need_chairman_approve
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods
       
        def made_approve(options = {})
          configuration = {need_second_approve_method: "undefined_the_method"}.merge(options)
          Approve.need_chairman_approve = configuration[:need_second_approve_method]
          include Approve::InstanceMethods
          include AASM
          enum status: ["auditting","acceptting","rejectting","last_acceptting","last_rejectting","leader_agree","leader_reject"]
           
          after_save  :add_to_approve,:if => Proc.new{|c| Rails.env=="production"}
          after_save :sync_to_leave_detail
          aasm :column => :status, :enum => true do
           # state :applying
     	    state :auditting, :initial => true
      		state :acceptting
      		state :rejectting
      		state :last_acceptting
      		state :last_rejectting
      		state :leader_agree
      		state :leader_reject
    
           	event :audit do
         		transitions :from => :applying, :to => :auditting#, :guard => :send_apply_mail
      		end
      		event :accept do
      	 		transitions :from => :auditting, :to => :acceptting#, :guard => :send_superior_mail
      		end
      		event :reject do
      	 		transitions :from => :auditting, :to => :rejectting#, :guard => :send_finished_mail
      		end
      		event :last_accept do
      	 		transitions :from => :acceptting, :to => :last_acceptting#, :guard => :send_finished_mail
      		end
      		event :last_reject do
      	 		transitions :from => :acceptting, :to => :last_rejectting#, :guard => :send_finished_mail
      		end
      		#两位领导的审批 将显示的审批状态
      		#表示请假被领导同意
      		event :system_agree  do
        		transitions :from => [:acceptting,:last_acceptting], :to => :leader_agree
      		end
      		#请假被拒绝 用于统计
      		event :system_reject  do
        		transitions :from => [:rejectting,:last_rejectting], :to => :leader_reject
      		end

      	  end
       
        end
    end

     
     module InstanceMethods

     	 def approve_class_name
     	 	self.class.name
     	 end

     	 def add_to_approve
     	 	 return if admin_modify
             begin 
     	 	 return if status=="leader_agree" || status== "leader_reject"
     	 	 method = self.class.class_variable_get("@@need_chairman_approve")
   
     	 	 case status 
     	 	 when "auditting"
                  LeaveMailer.approve_email(self).deliver_later
              when "acceptting"  
            
              	if self.send(method)
              	  LeaveMailer.chairman_approve_email(self).deliver_later 
              	else
              	   self.system_agree
              	   self.save
              	end 
              when "last_acceptting" || "leader_agree"
              	  LeaveMailer.finished_email(self).deliver_later
              	  self.system_agree
              	  self.save
              when "last_rejectting","rejectting"
              	  LeaveMailer.remind_email(self).deliver_later
              	  self.system_reject
              	  self.save

              end
          rescue 
          end
              		

     	 	 #self.system_reject if ["rejectting","last_rejectting"].include? status

     	 end

     	 def sync_to_leave_detail
     	 	leave_details.each do |detail|
               detail.status = Leave.statuses[status]
               detail.save
     	 	end
     	 end
        
     end
 end