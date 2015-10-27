class NjLeavesController < ApplicationController
  
  #load_and_authorize_resource

  def index
    if params[:username].present? and params[:year].present?
      if user = User.where(username: params[:username].strip).first
        @year = params[:year].to_i 
        @nj_leave = UserNjLeave.where(user_id: user.try(:id), year: @year).first 
      else
        flash[:notice] = "找不到用户名为: #{params[:username]}的用户"
      end
    end
  end

  def search 
    redirect_to nj_leaves_path(params.slice(:username, :year))
  end

  def update
    @nj_leave = UserNjLeave.find(params[:id])
    remain_days = params[:user_nj_leave]['total_days'].to_i - params[:user_nj_leave]['leave_days'].to_i
    params[:user_nj_leave][:remain_days] = remain_days
    @nj_leave.update_attributes(nj_leave_params)
    flash[:notice] = "修改年假成功！"
    redirect_to nj_leaves_path(params.slice(:username, :year))
  end

  def show
    respond_with(@leave)
  end

  def new
    @leave = Leave.new
    respond_with(@leave)
  end

  def create
    @leave = Leave.new(leave_params) 
    kind = params["leave"]["leave_details_attributes"]["kind"] rescue nil
    @total_days=0
    @leave.user_id = current_user.id
    @leave.status="acceptting" if @leave.reporter1_id==current_user.id
    if kind && !kind.blank?
    	kind.each do |key|
          hash = params["leave"]["leave_details_attributes"][key] rescue nil
          next unless hash
          detail = LeaveDetail.new()
          detail.start_at=hash["start_at"]
          detail.end_at = hash["end_at"]
          detail.user_id = current_user.id
          detail.days = hash["days"]
          detail.start_at_half_day = hash["start_at_half_day"]
          detail.end_at_half_day = hash["end_at_half_day"]
          detail.kind=LeaveDetail.kinds.key(key.to_i)
          #binding.pry
          if key.to_i==0
              last_year_days=(hash["days"].to_f-current_user.last_year_annual)>=0 ? current_user.last_year_annual : hash["days"].to_f
              detail.last_year_days=last_year_days
              detail.this_year_days=hash["days"].to_f-last_year_days
          end
          @total_days +=hash["days"].to_f
          @leave.leave_details<<detail        
    	end
    else
    	flash[:notice]="没选择"
    	return respond_with(@leave,:location=>"/leaves/new",:notice=>"没有选择")
    end
    @leave.total_days = @total_days
    @leave.save
    respond_with(@leave)
  end

  def destroy
    @leave.destroy
    respond_with(@leave,notice: "删除成功")
  end

  private
    def set_leave
    	begin
        @leave = Leave.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        return redirect_to leaves_url , notice: '该假条已经删除 :)'
      end
    end

    def nj_leave_params
      params.require(:user_nj_leave).permit(:total_days, :leave_days, :remain_days)
    end

    def leave_params
      params.require(:leave).permit(:total_day, :start_at, :end_at, :title, :status,:image, :info,:reporter1_id,:reporter2_id)#, :image,leave_details_attributes: [:start_at,:end_at,:kind])#{"JSJ"=>[:start_at,:end_at],"kind"=>[]}})#.tap do |whitelisted|
    end
end
