class DateSettingsController < AdminController
  load_and_authorize_resource
  before_action :set_date_setting, only: [:show, :edit, :update, :destroy]

  def index
  	@flag = params[:flag] || "rest"
    @date_settings = DateSetting.where("work_status=?",DateSetting.work_statuses[@flag]).order("year desc")
    respond_with(@date_settings)
  end

  def show
    respond_with(@date_setting)
  end

  def new
    @date_setting = DateSetting.new(work_status: params[:is_work],year: Date.today.year)
    respond_with(@date_setting)
  end

  def edit
  end

  def create

    @date_setting = DateSetting.find_or_initialize_by(year: params[:date_setting]["year"],work_status: params[:date_setting]["work_status"]) 
    @date_setting.user_id = current_user.id
    flash[:notice] = "设定日期成功"  if @date_setting.update(date_setting_params)

    #@date_setting.save
    respond_with(@date_setting,:status => :created, :location => "/date_settings/is_work/#{@date_setting.work_status}")
  end

  def update
  	@date_setting.user_id = current_user.id
    flash[:notice] = "修改日期成功"  if @date_setting.update(date_setting_params)
    respond_with(@date_setting,:status => :updated, :location => "/date_settings/is_work/#{@date_setting.work_status}")
  end

  def destroy
    @date_setting.destroy
    respond_with(@date_setting,:status => :deleted, :location => "/date_settings/is_work/#{@date_setting.work_status}")
  end

  private
    def set_date_setting
      @date_setting = DateSetting.find(params[:id])
    end

    def date_setting_params
      params.require(:date_setting).permit(:year, :work_status, :data, :user_id)
    end
end
