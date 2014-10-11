class LeaveDetail < ActiveRecord::Base
	enum kind: ["NJ","SJ","BJ","GJ","JSJJL","QTJSJ","HJ","SAJ","WHTQJ","YHSYTQJ","YHYTQJ","GWTQJ","OTHER"]
	belongs_to :leave
end
