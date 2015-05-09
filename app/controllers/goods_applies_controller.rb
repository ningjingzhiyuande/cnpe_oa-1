class GoodsAppliesController < ApplicationController
  before_action :set_goods_apply, only: [:show, :edit, :update, :destroy,:auddit]
  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def index
    @goods_applies = GoodsApply.all
    respond_with(@goods_applies)
  end

  def show
    respond_with(@goods_apply)
  end

  def new
  	@item = find_item 
    @goods_apply = GoodsApply.new
    respond_with(@goods_apply)
  end

  def edit
  end

  def create
  	item = find_item
  	apply = item.goods_applies.build(goods_apply_params)
  	apply.user_id=current_user.id
    params["is_storage"] ? apply.do_finish_review : apply.need_review
    ids = item.reviews.where("kind=?",'apply').map(&:user_id)
    apply.reviewer_ids = ids.join(',')
    apply.current_reviewer_id=ids.first  
    apply.save
    respond_with(apply,:location=>goods_url,notice: "申请成功")
  end

  def update
    @goods_apply.update(goods_apply_params)
    respond_with(@goods_apply)
  end

  def destroy
    @goods_apply.destroy
    respond_with(@goods_apply)

  end

 def auddit
  	 @goods_apply.send(params[:e])
  	 if params["e"]=="reject"
  	 	@goods_apply.is_review_over=true
  	 else
     	review = @goods_apply.good.apply_reviews.where("user_id=?",@goods_apply.current_reviewer_id).first.lower_item
 
     	@goods_apply.current_reviewer_id=review.try(:user_id)

     	@goods_apply.is_review_over=true if review.nil?
     end
  	 #@goods_apply.current_reviewer_id=
  	 redirect_to goods_applies_url if  @goods_apply.save
  end


  private

    def set_goods_apply
      @goods_apply = GoodsApply.find(params[:id])
    end

    def goods_apply_params
      params.require(:goods_apply).permit(:apply_info, :apply_num)
    end

	def find_item
  		params.each do |name, value|
    		return $1.classify.constantize.find(value) if name =~ /(.+)_id$/ 
  		end
  		nil
	end
end
