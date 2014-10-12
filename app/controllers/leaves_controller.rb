class LeavesController < ApplicationController
   load_and_authorize_resource
   before_action :set_leave, only: [:show, :destroy,:auddit]

  def index
    @leaves = current_user.apply_leaves
    respond_with(@leaves)
  end

  def show
    respond_with(@leave)
  end

  def new
    @leave = Leave.new
    respond_with(@leave)
  end

  def receive
  	@leaves = Leave.where("reporter1_id=? or reporter2_id=?",current_user.id,current_user.id).order("status asc")

  end

  def auddit
  	 @leave.send(params[:e])
  	 redirect_to receive_leaves_url if  @leave.save
  end

  def auddit_from_mail
  	 return redirect_to leaves_url , notice: '该已经被审批过了 :)'  if  @leave.status != params["s"]
     email =  Base64.decode64(params["token"])
     motion =  Base64.decode64(params["e"])
     user = User.find_by(email: email)
      
     return render :text => "权限错误" unless user 
     #return render :text => "权限错误 " unless  [@leave.reporter1_id, @leave.reporter2_id].include? user.id 
     sign_in user  

     @leave.send(motion)
     redirect_to leaves_url if  @leave.save

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
          detail.kind=LeaveDetail.kinds.key(key.to_i)
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
    @leafe.destroy
    respond_with(@leave)
  end

  private
    def set_leave
      @leave = Leave.find(params[:id])
    end

    def leave_params
    	 #  binding.pry
      params.require(:leave).permit(:total_day, :start_at, :end_at, :title, :status,:image, :info,:reporter1_id,:reporter2_id)#, :image,leave_details_attributes: [:start_at,:end_at,:kind])#{"JSJ"=>[:start_at,:end_at],"kind"=>[]}})#.tap do |whitelisted|
       
         # whitelisted[:leave_details] = params[:product][:leave_details]
      # end
    end
end
