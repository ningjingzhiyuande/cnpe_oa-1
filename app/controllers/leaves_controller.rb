require "spreadsheet"
class LeavesController < ApplicationController
  
   before_action :set_leave, only: [:show, :destroy,:auddit,:auddit_from_mail]
   skip_before_filter :verify_authenticity_token, :only => [:destroy]
    load_and_authorize_resource
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

  def list
  	@leaves = Leave.all#pass_leaves.order("id desc")
  end

  def auddit
  	 @leave.send(params[:e])
  	 redirect_to receive_leaves_url if  @leave.save
  end

  def auddit_from_mail
  	 return redirect_to leaves_url , notice: '该请假已经被审批过了 :)'  if ["leader_agree","leader_reject"].include? @leave.status
     email =  Base64.decode64(params["token"])
     motion =  Base64.decode64(params["e"])
     user = User.find_by(email: email)
      return redirect_to leaves_url , notice: '该请假已经被审批过了 :)'  if (["acceptting","rejectting"].include? @leave.status) && (["accept","reject"].include? motion)
      
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
          detail.start_at_half_day = hash["start_at_half_day"]
          detail.end_at_half_day = hash["end_at_half_day"]
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

  def update
  
  	total_days = 0
  	details = params["leave"]["leave_details_attributes"]
  	details.each do |k,obj|
      detail = @leave.leave_details.find_by("kind=?",k)
      detail.start_at=obj["start_at"]
      detail.end_at = obj["end_at"]
      #detail.user_id = current_user.id
      detail.days = obj["days"]
      detail.start_at_half_day = obj["start_at_half_day"]
      detail.end_at_half_day = obj["end_at_half_day"] 
      detail.save
      total_days +=obj["days"].to_f
  	end
  	@leave.total_days = total_days
  	@leave.admin_modify=true
  	@leave.update_attributes(leave_params) 
    respond_with(@leave)
  end

  

 def export_data
    hash = {}
    y = params["year"].to_i || Date.today.year
 	month=params["month"].to_i || Date.today.mon
 	d = Date.new(y,month,1)
 	#加上审批的
 	details = LeaveDetail.where("status=? or status=?",Leave.statuses["last_acceptting"],Leave.statuses["leader_agree"]).where('(start_at>=? and start_at<=?) or (end_at>=? and start_at<=?)',d,d.end_of_month,d,d)
    details.each do |detail|
    	k = detail.kind

    	n = detail.user.name
    	(hash.key? n) ? ((hash[n].key? k) ?  hash[n][k]=hash[n][k].concat(detail.month_static(y,month)) : hash[n].merge!({k=>detail.month_static(y,month)})) : hash[n]={k=>detail.month_static(y,month)}
    end

    #return render :text=> hash.inspect
 	Spreadsheet.client_encoding = "UTF-8"
    bookString = StringIO.new
    book = Spreadsheet::Workbook.new("#{Rails.root}/public/leaves_10.xls")
    sheet1 =  book.create_worksheet
    sheet1.row(0).push "采购请假表(√ 表示一天,△代表上午▽代表下午)"
    diff = d.end_of_month.mday
    sheet1.row(1).replace ("0".."#{diff}").to_a 
    sheet1.row(1).insert 1 ,"姓名\\日期"
    sheet1[1,0]="序号"
    LeaveDetail.kinds.each do |k,v|
      sheet1.row(1).push(I18n.t("leave_details.#{k}"))
    end 
    hash.keys.each_with_index do |key,i|
    	sheet1[i+2,0] = i+1
    	sheet1[i+2,1] = key.to_s
        h=hash[key]
        h.each do |k,v|
           t_days = 0
           v.each do |num|
           	  if num.integer?
           	  	t_days=t_days+1
           	  	sheet1[i+2,1+num.to_i]="√"
           	  elsif (num*10%10).to_i==1
                sheet1[i+2,1+num.to_i]="△"
                t_days=t_days+0.5
              elsif (num*10%10).to_i==2
              	sheet1[i+2,1+num.to_i]="▽"
              	t_days=t_days+0.5
           	  end
           	  	
           end
           sheet1[i+2,LeaveDetail.kinds[k]+2+diff]=t_days.to_s
        end
    end

    book.write bookString
    send_data bookString.string,:filename => "采购部#{month}月份考勤.xls"

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

    def leave_params
    	 #  binding.pry
      params.require(:leave).permit(:total_day, :start_at, :end_at, :title, :status,:image, :info,:reporter1_id,:reporter2_id)#, :image,leave_details_attributes: [:start_at,:end_at,:kind])#{"JSJ"=>[:start_at,:end_at],"kind"=>[]}})#.tap do |whitelisted|
       
         # whitelisted[:leave_details] = params[:product][:leave_details]
      # end
    end
end
