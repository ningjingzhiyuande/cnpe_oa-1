class LeaveDetail < ActiveRecord::Base
	enum kind: ["NJ","SJ","BJ","GJ","JSJJL","QTJSJ","HJ","SAJ","WHTQJ","YHSYTQJ","YHYTQJ","GWTQJ","OTHER"]
	#KIND={"NJ"=>"年假", "SJ"=>"事假", "BJ"=>"病假", "GJ"=>"公假", "JSJJL"=>"计生假(含奖励假)", "QTJSJ"=>"其他计划生育假", "HJ"=>"婚假", "SAJ"=>"丧假", "WHTQJ"=>"未婚一年一次探父母", "YHSYTQJ"=>"已婚四年一次探父母", "YHYTQJ"=>"已婚一年探配偶", "GWTQJ"=>"国外探亲假", "OTHER"=>"其他"}
	belongs_to :leave
	belongs_to :user

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


  def month_static(year=Date.today.year,month)
  	    begin_date = Date.new(year,month,1)
  	    end_month_date = begin_date.end_of_month
  	    s_date = self.start_at.try(:to_date)
  	    e_date = self.end_at.try(:to_date)
  	    return [] if s_date.nil? or e_date.nil?
  	    if begin_date>s_date
  	    	start_date = begin_date
  	    	start_hour=0
  	    else
  	    	start_date = s_date
  	    	start_hour= start_at_half_day==1 ? 0 : 0.2
  	    end
		if end_month_date>=e_date
			end_date = e_date
			end_hour = end_at_half_day==1 ? 0.1 : 0
		else
			end_date =  start_date.end_of_month
			end_hour =  0
		end
		#start_hour= detail.start_at_half_day==1 ? 0 : 0.2 #0.1表示上午 0.2 下午
		
		diff = end_date-start_date
		array=[]
		if diff==0 
			return [start_date.mday] if days==1
			return [start_date.mday+start_hour] if days==0.5
			return []
		end
		(0..diff).each do |i|
		   #end_month_d = start.end_of_month

		   date = start_date+i

		   is_work_day = DateSetting.judge_work_day(date)
		   next unless is_work_day
           if i==0 
              array.push(date.mday+start_hour) 
              next
           end
           if(i!=diff)
              array.push(date.mday)
           else
              array.push(date.mday+end_hour)
           end 
        end
        return array

  end
end
