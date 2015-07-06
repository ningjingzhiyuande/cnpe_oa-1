class Category < ActiveRecord::Base

	enum kind: ["dept","rank"]
	enum status: ["enable","disenable"]

    scope :departments, -> { where(kind: 0) }
    scope :ranks, -> { where(kind: 1) }

    before_save :syn_department_num_user
    def syn_department_num_user
       if self.kind=="dept" && item_num_changed? 
       	 User.where("department_id=?",id).update_all(department_num: self.item_num)
       end
    end
end