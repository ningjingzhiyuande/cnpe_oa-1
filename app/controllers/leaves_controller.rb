require "spreadsheet"
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
      detail.user_id = current_user.id
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

 	Spreadsheet.client_encoding = "UTF-8"
    bookString = StringIO.new
    book = Spreadsheet::Workbook.new("#{Rails.root}/public/leaves_10.xls")
    #binding.pry
    leaves = Leave.order("user_id asc")
    sheet1 =  book.create_worksheet


   # timer = 1
   
    sheet1.row(0).push "采购请假表"
  #  sheet1[1,0] = "姓名日期"
   # (0..31).each do |i|
   #sheet1.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
      #                  'Author of original code for Spreadsheet::Excel' ]
    sheet1.row(1).replace ("0".."31").to_a 

    sheet1.row(1).insert 1 ,"姓名\\日期"
    sheet1[1,0]="序号"
    sheet1.row(1).push("年假","事假")
    hash = {}


   # end
    leaves.each_with_index do |leave,index|
       name = leave.applicant.name
    #	binding.pry
     # sheet1[index+2,0] = index+1
   	 # sheet1[index+2,1] = leave.applicant.name
      leave.leave_details.each do |detail|
      	start_at = detail.start_at
      	end_at = detail.end_at
      	next if start_at.blank? || end_at.blank?
      	diff=(end_at-start_at)
      	(0..diff.to_i/86400).each do |i|
      	   date = start_at.since(i*86400).to_date.day

      	   (hash.key? name) ? hash[name]<<date.to_s : hash[name]=[date.to_s]
      	 # leave.applicant.name=[date.to_s]
      	end
         
      end
    #  timer +=1
    end
   
    hash.keys.each_with_index do |key,i|
    #	 binding.pry
    	sheet1[i+2,0] = i+1
    	sheet1[i+2,1] = key.to_s
    	hash[key].uniq.each do |v|
           sheet1[i+2,1+v.to_i]=v
    	end
    	#sheet1.row(i+2).push(hash[key].uniq.join(","))
    end

    book.write bookString
    send_data bookString.string,:filename => '123.xls'

 end


  def destroy
   # @leafe.destroy
   # respond_with(@leave)
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
