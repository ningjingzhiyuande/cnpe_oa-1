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


	def self.auddit_users
		User.where(role_id: User.role_ids["good_manager"])
	end

	def self.auddit_users_mail
		self.auddit_users.map(&:email)
	end

	def self.auddit_user_ids
		self.auddit_users.map(&:id)
	end





	def apply_info
        loan_info
	end

end
