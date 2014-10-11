module ApplicationHelper

	def rest_days
	   str = []
      dates = DateSetting.where("work_status=?",DateSetting.work_statuses["rest"]).order("year desc")
      dates.map{|d|str.push(d.data)}
      str.join(",")
	end
	def work_days
	   str = []
      dates = DateSetting.where("work_status=?",DateSetting.work_statuses["work"]).order("year desc")
      dates.map{|d|str.push(d.data)}
      str.join(",")
	end

end
