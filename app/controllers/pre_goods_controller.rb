class PreGoodsController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => [:update,:create]
  before_action :set_pre_good, only: [:show, :edit, :update, :destroy]
   layout "application_no_header",only: [:new,:create]

  def index
    @pre_goods = PreGood.all.order("updated_at desc")
    respond_with(@pre_goods)
  end

  def show
    respond_with(@pre_good)
  end

  def new
    @pre_good = PreGood.new
 #   return render "new",layout: false
    #respond_with(@pre_good)
  end

  def  orders 
  	@orders = Order.all.order("id desc ,status asc").group("order_key").count
  end

  def order_show
  	@orders = Order.where(order_key:  params["order_key"])
  end

  def auddit
  	orders = Order.where(order_key:  params["order_key"])
    orders.each do |order|
  	  order.send(params[:e])
  	  order.save
  
  	end	 
  	redirect_to :back,notice: "操作成功！"
  end

  def edit
  end

  def create
    @pre_good = PreGood.new()
    @pre_good.name=params["name"]
    @pre_good.num=params["num"]
    @pre_good.price=params["price"]
    @pre_good.is_consume=params["is_consume"]
    return render json: {data: "ok"} if @pre_good.save
    #respond_with(@pre_good)
  end

  def update 
    if @pre_good.update!(pre_good_params)
      render json: :ok
    else
      render :json => @pre_good.errors.full_messages, :status => :unprocessable_entity
    end

    #respond_with(@pre_good)
  end

  def order
  	order_key=Time.now.to_i.to_s+rand(10000).to_s
  	goods = PreGood.find params["ids"]
  	goods.each do |g|
  		Order.create(order_key: order_key,pre_good_id: g.id,num: g.num,price: g.price,user_id: current_user.id,name: g.name)
  	end
  	#todo 审核
  	redirect_to :back,notice: "请等待领导审核"

  end

  def destroy
    @pre_good.destroy
    respond_with(@pre_good)
  end

  private
    def set_pre_good
      @pre_good = PreGood.find(params[:id])
    end

    def pre_good_params
      params.require(:pre_good).permit(:name, :num, :price, :is_consume)
    end
end
