require 'examine'
class LoanGood < ActiveRecord::Base
	include Examine
	belongs_to :good

end
