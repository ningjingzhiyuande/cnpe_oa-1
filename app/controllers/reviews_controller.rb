class ReviewsController < ApplicationController
	#load_and_authorize_resource
	layout "application_no_header"
	#before_action :find_item,only: [:new]
	skip_before_filter :verify_authenticity_token,only: [:create]#, :if => Proc.new { |c| c.request.format == 'application/json' }
  	#before_action :record_apply_goods,only: [:create,:update]
  	def index
  	end

  	def new
  		@item = find_item
  		@review = Review.new
  	
  	end

  	def create
  		item = find_item
  		item.reviews.where("kind=?", params["review_type"]).destroy_all
  		params["users"].each do |user_id|
          item.reviews.create({user_id: user_id,kind: params["review_type"]})
  		end

  		return render json: {data: "ok"}

  	end

  	def edit
  	end


private
 

	def find_item
  		params.each do |name, value|
    		return $1.classify.constantize.find(value) if name =~ /(.+)_id$/ 
  		end
  		nil
	end
end
