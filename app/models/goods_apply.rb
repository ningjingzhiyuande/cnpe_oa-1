require 'examine'
class GoodsApply < ActiveRecord::Base
	include Examine
	belongs_to :good

	#after_save :set_apply_num_for_goods


	def self.create_detail(goods,need_review_flag,apply_num)
		apply = goods.goods_applies.build(apply_num: apply_num,user_id: goods.user_id)
        need_review_flag ? apply.do_finish_review : apply.need_review
        apply.reviewer_ids = goods.reviews.where("kind=?",'apply').map(&:user_id).join(',')
		apply.save
	end

	
	

	def set_apply_num_for_goods
		#self.good.increment!(:stock_num,self.apply_num) if finished?
		#self.good.increment!(:apply_num,self.apply_num) if init?


	end
	
    #enum status: ["auditting","acceptting","rejectting","last_acceptting","last_rejectting","leader_agree","leader_reject"]
end
