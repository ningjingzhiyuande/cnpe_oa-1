class UsersController < ApplicationController
	
  load_and_authorize_resource

  def index
  	users = User.order("id desc")
  	if params[:is_approve] 
       is_approve = params[:is_approve] == "yes" ? 1 : 0
       users = users.where("is_approve=?",is_approve)
    end
    @users = users

  end

  def edit
  	@user = User.find params[:id]
  end
  def approve
    @user = User.find params[:id]
    @user.toggle!(:is_approve)
    redirect_to :back, :notice => "修改成功"
  end
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path, :notice => "修改成功"
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
   private
  
    def user_params
      params.require(:user).permit(:name, :username, :rank_id, :department_id, :email, :password, :password_confirmation,:work_at)
    end
end