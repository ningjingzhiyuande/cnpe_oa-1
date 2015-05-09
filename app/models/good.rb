class Good < ActiveRecord::Base
	has_many :reviews,as: :item#,order: "position"
	has_many :apply_reviews,-> { where kind: 'apply' }, class_name: 'Review',as: :item
	has_many :loan_reviews,-> { where kind: 'loan' }, class_name: 'Review',as: :item,as: :item
	has_many :goods_applies
	has_many :loan_goods
end
