
class PreGood < ActiveRecord::Base
	
	validates :num, numericality: true,allow_blank: true
	validates :price, numericality: true,allow_blank: true
	

end
