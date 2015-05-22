class LoanGoodMailer < ActionMailer::Base
  default from: "oreatial@163.com"

  def send_mail(obj)
  	@url="http://cgboffice.cnpe.cc"

    @obj = ActiveModel::GlobalLocator.locate(obj) 
    status = @obj.status
  	@reviewer = User.find @obj.current_reviewer_id   if @obj.current_reviewer_id
  	case status
  	when "auditting"
      mail(to: @reviewer.email,subject: "物品申请审核：#{@obj.good.try(:name)}, 请您审核", 
          	template_path: 'goods_apply_mailer',template_name: 'finished') if @reviewer.present?
  	when "acceptting" && @obj.is_review_over
  		mail(to: @obj.user.email,subject: "您申请的物品：#{@obj.good.name}已经被通过",
          	template_path: 'goods_apply_mailer', template_name: 'finished')  
  	when "acceptting" && !@obj.is_review_over
          mail(to: @reviewer.email,subject: "物品申请审核：#{@obj.good.try(:name)},上一步审核已经通过，请您进一步审核",
          	bcc: @obj.user.email, template_path: 'goods_apply_mailer', template_name: 'finished') if @reviewer.present?
  	when "rejectting"
  		mail(to: @obj.user.email,subject: "您申请的物品：#{@obj.good.name}已经被拒绝",
          	template_path: 'goods_apply_mailer', template_name: 'finished')

  	end
  		
  end
end
