class DashboardsController < ApplicationController
  def index
    if current_user.rank_id=="chief" 
        @pending_leaves = Leave.where("status=? and user_id=?",Leave.statuses["acceptting"],current_user.id).order("id desc").limit(6)
  	else
  		@pending_leaves = Leave.where("status=? and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["auditting"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
    end
    @leaves = Leave.where("(status=? or status=? or status=?) and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
    @approved = Leave.where("status=? and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["leader_agree"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
  end
end
