#每个要审核的列表中必须包含下面三个字段
#t.string :reviewer_ids
#t.integer :current_reviewer_id
#t.boolean :is_review_over,default: false
module Examine #:nodoc:
    extend ActiveSupport::Concern
	included do 
		#has_many :reviews,as: :item, order: "position",dependent: :destroy
		#after_save :init_current_review
		after_save :init_and_send_mail   
        include AASM
        enum status: ["auditting","acceptting","rejectting"]

        aasm :column => :status, :enum => true do
           # state :applying
     	    state :auditting, :initial => true
      		state :acceptting
      		state :rejectting
      	
      		event :accept do
      	 		transitions :from => [:auditting,:acceptting,:rejectting], :to => :acceptting#, :guard => :send_superior_mail
      		end
      		event :reject do
      	 		transitions :from => [:auditting,:acceptting,:rejectting], :to => :rejectting#, :guard => :send_finished_mail
      		end
      	
      	 end

        def can_review_apply?(user)
        	user.id == current_reviewer_id && !is_review_over
        end

       
      	def init_and_send_mail

      	end

      	def need_review
	   		self.status="auditting"
		end

		def do_finish_review
     		self.status="acceptting"
     		self.is_review_over=true
		end

		


	end

	class_methods do 
		def accept_status
			"acceptting"	   		
      	end
      	def reject_status
      		"rejectting"
      	end
	end

 end