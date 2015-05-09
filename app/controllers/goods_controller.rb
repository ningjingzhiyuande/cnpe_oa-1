class GoodsController < ApplicationController
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

  def create
    @good = Good.new(good_params)
    @good.user_id=current_user.id
    @good.save
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
