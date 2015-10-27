namespace :annual do
  desc '计算年假' 
  task :days => :environment do 
  	User.all.each do |u|
      UserNjLeave.reset!(u, Date.today.last_year)
    end
  end
end
