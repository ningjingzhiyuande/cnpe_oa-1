require 'examine'
class Order < ActiveRecord::Base
	include Examine
	belongs_to :pre_good
	belongs_to :user

	before_save :generate_goods

    def generate_goods
    	return if status!="acceptting"
    	goods = Good.find_or_initialize_by(name: self.pre_good.name)
    	goods.stock_num=goods.stock_num+self.num
    	goods.is_consume = self.pre_good.is_consume
    	goods.is_return = self.pre_good.is_consume
    	goods.save

    end


	def self.auddit_users
		User.where(email: "shiguodong@tianji.com")
	end

	def self.auddit_users_mail
		self.auddit_users.map(&:email).first
	end

	def self.auddit_user_ids
		self.auddit_users.map(&:id).first
	end

	def init_and_send_mail
      		#(self.class.name+"Mailer").constantize.send_mail(self).deliver_later 
    end
end
