class ReviewDetail < ActiveRecord::Base
    belongs_to :item, polymorphic: true
    belongs_to :review
    
end
