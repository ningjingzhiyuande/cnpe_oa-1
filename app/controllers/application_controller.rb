class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :html,  :json

  before_action :authenticate_user!
  before_action :approve_user

 # private 

 rescue_from CanCan::AccessDenied do |exception|

  flash[:notice] = "您没有相关权限,请联系管理员."
  redirect_to (request.referer || root_url)
end


  def approve_user
  	 #binding.pry
    
    unless current_user.is_approve
    	sign_out current_user
    	render :text=>"您的账户还在审核中...." 
    end

  end
end
