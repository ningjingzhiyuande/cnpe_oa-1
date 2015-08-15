namespace :annual do
	
   desc '计算年假' 
   task :days => :environment do 
   	   User.all.each do |u|
   	   	  total_days = u.nj_days(Date.today.last_year.end_of_year)
   	   	  residual_days = u.residual_annual_days(Date.today.year-1)
   	   	  unl=UserNjLeave.find_or_create_by({user_id: u.id,year: Date.today.year-1})
   	   	  unl.total_days=total_days
   	   	  unl.remain_days=residual_days
   	   	  unl.leave_days=total_days-residual_days
   	   	  unl.save
   	   end
   end
end
