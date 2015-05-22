class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
  respond_to :html,  :json

  before_action :authenticate_user!

  before_action :approve_user
  before_action :auto_sign_in_from_mail


 # private 

 rescue_from CanCan::AccessDenied do |exception|
  flash[:notice] = "您没有相关权限,请联系管理员."
  redirect_to (request.referer || dashboards_url)
end

private
  def approve_user
    unless current_user.is_approve
    	sign_out current_user
    	render :text=>"您的账户还在审核中...." 
    end

  end
  def auto_sign_in_from_mail
  	return if params["token"].blank?
  	email =  params["token"]#Base64.decode64(params["token"]) 
    user = User.find_by(email: email)
    return unless user.present?
    sign_in user 
  end
end
