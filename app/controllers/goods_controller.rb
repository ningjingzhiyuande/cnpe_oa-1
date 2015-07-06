class GoodsController < ApplicationController
  load_and_authorize_resource	
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def index
    @goods = Good.all
    respond_with(@goods)
  end

  def show
    respond_with(@good)
  end

  def new
    @good = Good.new
    respond_with(@good)
  end

  def edit
  end

  def apply_analysis
    @title = "物品入库统计"
  	@applies = Order.where("status=?",1)
  #	binding.pry
  	@applies = @applies.where("name=?",params[:name]) unless params["name"].blank?
  #	@applies = @applies.where("status=?",params[:status]) unless params["status"].blank?
  	@applies = @applies.where("created_at>=?",params[:start_at]) unless params["start_at"].blank? || params["start_at"].to_time.blank?
  	@applies = @applies.where("created_at<=?",params[:end_at]) unless params["end_at"].blank? || params["end_at"].to_time.blank?
   # @applies = @applies.where("status=2")if !params["status"].blank? && params["status"]=="2"
   # @applies = @applies.where("is_review_over=0 and status!=2") if !params["status"].blank? && params["status"]=="0"
   # @applies = @applies.where("is_review_over=1 and status=1") if !params["status"].blank? && params["status"]=="1"

    
  end

  def loan_analysis
  	@applies = LoanGood.all
    @title = "物品出库统计"
  	@applies = @applies.where("good_id=?",params[:good_id]) unless params["good_id"].blank?
  #	@applies = @applies.where("status=?",params[:status]) unless params["status"].blank?
  	@applies = @applies.where("created_at>=?",params[:start_at]) unless params["start_at"].blank? || params["start_at"].to_time.blank?
  	@applies = @applies.where("created_at<=?",params[:end_at]) unless params["end_at"].blank? || params["end_at"].to_time.blank?
    @applies = @applies.where("status=2")if !params["status"].blank? && params["status"]=="2"
    @applies = @applies.where("is_review_over=0 and status!=2") if !params["status"].blank? && params["status"]=="0"
    @applies = @applies.where("is_review_over=1 and status=1") if !params["status"].blank? && params["status"]=="1"
    #render "goods/apply_analysis"
  end

  def create
    @good = Good.new(good_params)
    @good.user_id=current_user.id
    flash["notice"]= "物品创建成功"  if @good.save


   # GoodsApply.create_detail(@good,params["is_storage"],params["apply_num"].to_i) if params["apply_num"].to_i>0
    respond_with(@good,location: goods_url)
  end

  def update
  	#binding.pry
  	num = @good.apply_num+good_params["apply_num"].to_i
  	#GoodApply.create_detail(@good,params["is_storage"])
    @good.update(good_params.merge(apply_num: num))
    @good.apply_num=@good.apply_num+num
    respond_with(@good,location: goods_url)
  end

  def destroy
    @good.destroy
    respond_with(@good,location: goods_url)
  end

  private
    def set_good
      @good = Good.find(params[:id])
    end

    def good_params
      params.require(:good).permit(:name, :descript, :is_consume)
    end
end
