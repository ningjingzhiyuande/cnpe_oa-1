class LeaveDetail < ActiveRecord::Base
	enum kind: ["NJ","SJ","BJ","GJ","JSJJL","QTJSJ","HJ","SAJ","WHTQJ","YHSYTQJ","YHYTQJ","GWTQJ","OTHER"]
	belongs_to :leave

	#申请和被审批通过的请假
   def self.apply_and_accept(uid)
   	   LeaveDetail.where("user_id=? and (status=? or status=? or status=? or status=?) and kind=0",uid,Leave.statuses["auditting"],Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"])    
   end

  

  def self.apply_and_accept_shijia(uid)
   	   LeaveDetail.where("user_id=? and (status=? or status=? or status=? or status=?) and kind=1 and start_at>= #{Date.today.beginning_of_year} and start_at<= #{Date.today.end_of_year}",uid,Leave.statuses["auditting"],Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"])    
  end

  def self.apply_and_accept_sangjia(uid)
   	   LeaveDetail.where("user_id=? and (status=? or status=? or status=? or status=?) and kind=7 and start_at>= #{Date.today.beginning_of_year} and start_at<= #{Date.today.end_of_year}",uid,Leave.statuses["auditting"],Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"])    
  end
   def self.apply_and_accept_bingjia(uid)
   	   LeaveDetail.where("user_id=? and (status=? or status=? or status=? or status=?) and kind=2 and start_at>= #{Date.today.beginning_of_year} and start_at<= #{Date.today.end_of_year}",uid,Leave.statuses["auditting"],Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"])    
  end
end
