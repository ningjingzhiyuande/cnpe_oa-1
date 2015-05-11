class HomeController < ApplicationController
	skip_before_action :authenticate_user!
    skip_before_action :approve_user
	layout "cms"
  def index
  end
  def about_us
  	
  end
end
