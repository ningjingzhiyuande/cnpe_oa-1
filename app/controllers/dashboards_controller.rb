class DashboardsController < ApplicationController
  def index
  	#binding.pry
    if current_user.rank_id=="chairman" 
        @pending_leaves = Leave.where("status=? and user_id=?",Leave.statuses["acceptting"],current_user.id).order("id desc").limit(6)
  	else
  		@pending_leaves = Leave.where("status=? and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["auditting"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
    end

    @goods_applies = GoodsApply.where("(current_reviewer_id=? or user_id=?) and is_review_over=0",current_user.id,current_user.id)
    @loan_applies = LoanGood.where("(current_reviewer_id=? or user_id=?) and is_review_over=0",current_user.id,current_user.id)
    @finish_goods_applies = GoodsApply.where("user_id=? and is_review_over=1",current_user.id)
    @finish_loan_applies = LoanGood.where("user_id=? and is_review_over=1",current_user.id)
    
    @entretains =Entretain.where("(last_reporter_id=? or reporter_id=? or user_id=?) and aasm_state in ('applying','auditting','acceptting')", current_user.id,current_user.id,current_user.id)
    @finish_entretains =Entretain.where("user_id=? and aasm_state in ('last_acceptting','last_rejectting','rejectting','finished')", current_user.id)

    @leaves = Leave.where("(status=? or status=? or status=?) and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["acceptting"],Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
    @approved = Leave.where("status=? and (user_id=? or reporter1_id=? or reporter2_id=?)",Leave.statuses["leader_agree"],current_user.id,current_user.id,current_user.id).order("id desc").limit(6)
  end
end
