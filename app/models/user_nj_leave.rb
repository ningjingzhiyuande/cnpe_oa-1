class UserNjLeave < ActiveRecord::Base
  #attr_accessible :total_days, :leave_days, :remain_days
  belongs_to :user

  def self.days_for(user, past_year_day=Date.today.last_year)
     total_days = user.nj_days(past_year_day.end_of_year)
     leave_days = user.leave_nj_days(past_year_day.year)
     {
       total_days: total_days,
       leave_days: leave_days,
       remain_days: total_days - leave_days
     }
  end

  def self.reset!(user, past_year_day=Date.today.last_year)
     unl=find_or_create_by({user_id: user.id, year: past_year_day.year})
     unl.update_attributes(days_for(user, past_year_day))
  end
end
