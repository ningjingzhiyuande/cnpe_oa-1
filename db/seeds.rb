# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.connection.execute("TRUNCATE TABLE user_nj_leaves")

User.all.each do |user|
	year_day=(Date.today-1.year).end_of_year
	nj_days=user.nj_days(year_day)
	user_n = UserNjLeave.create(user_id: user.id,total_days:nj_days,leave_days: nj_days,remain_days: 0,year: year_day.year)

	applied_days = LeaveDetail.where("user_id=? and leave_year=? and (status=? or status=?) and kind=0",user.id,year_day.year,Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"]).sum("days").to_f

  if applied_days>0
     user_n.leave_days=applied_days
     user_n.remain_days=nj_days-applied_days
     user_n.save
  end
end
