class DateSetting < ActiveRecord::Base

	enum work_status: ["rest","work"]

	def self.judge_work_day(date)
		wday = date.wday
		if (1..5).to_a.include? wday
		   dates = DateSetting.find_by(year: date.year,work_status: 0)
		   return (dates.data.split(",").include? date) ? false : true rescue true
	    else
	       dates = DateSetting.find_by(year: date.year,work_status: 1)
	       return (dates.data.split(",").include? date) ? true : false rescue false
	    end


	end
end
