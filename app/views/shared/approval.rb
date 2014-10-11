module Approval
	def self.included(base)
        base.extend(ClassMethods)
    end
    module ClassMethods
       
        def approval_for(options = {})
        end


    end
end