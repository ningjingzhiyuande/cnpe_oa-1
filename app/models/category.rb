class Category < ActiveRecord::Base

	enum kind: ["dept","rank"]
	enum status: ["enable","disenable"]

    scope :departments, -> { where(kind: 0) }
    scope :ranks, -> { where(kind: 1) }
end