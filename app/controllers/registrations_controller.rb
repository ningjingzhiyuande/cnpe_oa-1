class RegistrationsController < Devise::RegistrationsController
	layout false
	skip_before_action :approve_user
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :username, :rank_id, :department_id, :email, :password, :password_confirmation,:work_at)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :username, :rank_id, :department_id, :email, :password,:work_at, :password_confirmation, :current_password)}
  end

end
