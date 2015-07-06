class LoanGoodsController < ApplicationController
 # load_and_authorize_resource
  layout "application_no_header",only: [:new,:create]
  before_action :set_loan_good, only: [:show, :edit, :update, :destroy,:auddit]
  skip_before_filter :verify_authenticity_token,only: [:create]
  before_action :check_auddit_user

  def index
  	@loan_goods = case params["status"]
  	when "auddit"
        LoanGood.where("is_review_over=0")
  	when "finished"
  		LoanGood.where("is_review_over=1 and status=?",1)
  	when "reject"
  		LoanGood.where("is_review_over=1 and status=?",2)
  	when "return"
  		LoanGood.where("is_review_over=1 and status=? and end_at>=?",1,Time.now)
  	else	
   		LoanGood.all
	end
    @loan_goods = @loan_goods.where("user_id=?",current_user.id) unless LoanGood.auddit_user_ids.include? current_user.id

    respond_with(@loan_goods)
  end

  def list
  		@loan_goods =LoanGood.all
  		render "index"
  end

  def goods
  	@goods = Good
  	@goods = @goods.where(is_consume: true) if params["is_consume"].to_i==1
  	@goods = @goods.where(is_consume: false) if params["is_consume"].to_i==0

  end

  def show
    respond_with(@loan_good)
  end

  def new
  	@goods = find_item
    @loan_good = LoanGood.new
    respond_with(@loan_good)
  end

  def edit
  end

  def create
  	item = find_item
  	loan_goods = item.loan_goods.build
  	loan_goods.apply_num = params["apply_num"]
  	loan_goods.loan_info = params["loan_info"]
  	loan_goods.is_consume = item.is_consume
  	loan_goods.end_at = params[:end_at]
  	ids = item.loan_reviews.map(&:user_id)
    loan_goods.reviewer_ids = ids.join(',')
    loan_goods.current_reviewer_id=ids.first  
  	
  	loan_goods.user_id = current_user.id
    return render json: {data: "ok"} if loan_goods.save

  end

  

  def auddit
  	 @loan_good.send(params[:e])
     @loan_good.is_review_over=true
     redirect_to loan_goods_url if  @loan_good.save
  	 	#@loan_good.current_reviewer_id=nil
  #	 else
  #   	review = @loan_good.good.loan_reviews.where("user_id=?",@loan_good.current_reviewer_id).first.lower_item
 
   #  	@loan_good.current_reviewer_id=review.try(:user_id)
#
 #    	@loan_good.is_review_over=true if review.nil?
  #   end
  	 #@goods_apply.current_reviewer_id=
  	 
  end

  def update
    @loan_good.update(loan_good_params)
    respond_with(@loan_good)
  end

  def destroy
    @loan_good.destroy
    respond_with(@loan_good)
  end

  private
    def set_loan_good
      @loan_good = LoanGood.find(params[:id])
    end

    def loan_good_params
      params.require(:loan_good).permit(:good_id, :start_at, :end_at, :loan_info, :user_id, :status)
    end

	def find_item
  		params.each do |name, value|
    		return $1.classify.constantize.find(value) if name =~ /(.+)_id$/ 
  		end
  		nil
	end
   def check_auddit_user
   	  return render text:  "没有设定物品外借审核人员，请联系管理员" if LoanGood.auddit_users.count==0
   end

end

