require 'examine'
class LoanGood < ActiveRecord::Base
	include Examine
	belongs_to :good
	belongs_to :user

	after_save :set_apply_num_for_goods

	def set_apply_num_for_goods
		self.good.increment!(:loan_num,self.apply_num) if status=="acceptting" && is_review_over?
		#self.good.increment!(:apply_num,self.apply_num) if init?
	end

	def apply_info
        loan_info
	end

end
