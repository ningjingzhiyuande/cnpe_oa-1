class LeaveMailer < ActionMailer::Base
  default from: "oreatial@163.com"
  #after_action :set_system_status
  
  def approve_email(obj)
  #	binding.pry
  	 @leave = ActiveModel::GlobalLocator.locate(obj) 
  	 @url = "http://192.81.135.229"
  	 #@leave.chief.email	 
  	 mail(to: @leave.chief.email, subject: @leave.applicant.name+": #{@leave.title},一共请假#{@leave.total_days}天,请您审批")
  end

  def  chairman_approve_email(obj)
  	 @leave = ActiveModel::GlobalLocator.locate(obj) 
  	 @url = "http://192.81.135.229"
  	 mail(to: @leave.chairman.email, subject: @leave.applicant.name+": #{@leave.title},一共请假#{@leave.total_days}天,请您审批")
  end
        
  def finished_email(obj)
  	 @leave = ActiveModel::GlobalLocator.locate(obj) 
  	 mail(to: @leave.applicant.email, subject: @leave.applicant.name+": #{@leave.title},一共请假#{@leave.total_days}天,已经被领导审批通过")
  end
  def remind_email(obj)
  	 #@leave = ActiveModel::GlobalLocator.locate(obj) 
  end

  private
  
  def set_system_status
  	 status = @leave.status
  	 method = Leave.class_variable_get("@@need_chairman_approve")
  	 case status
  	 when "acceptting"
  	 	@leave.update!(status: "leave_agree") unless @leave.send(method)
  	 when "rejectting","last_rejectting"
  	 	@leave.update!(status: "leave_reject")
  	 end
  	# @leave.system_reject if ["rejectting","last_rejectting"].include? status
  end
end
