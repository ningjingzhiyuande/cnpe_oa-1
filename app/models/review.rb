class Review < ActiveRecord::Base
	belongs_to :item, polymorphic: true
	#include RankedModel
	acts_as_list :scope=>["item_id item_type kind"]
   # ranks :row_order, :column => :position,with_same: :kind  
    belongs_to :user
end
