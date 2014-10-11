class SessionsController < Devise::SessionsController
	layout false
	skip_before_action :approve_user
end
