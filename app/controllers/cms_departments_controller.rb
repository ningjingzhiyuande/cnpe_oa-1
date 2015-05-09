class CmsDepartmentsController < ApplicationController
  before_action :set_cms_department, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def index
    @cms_departments = CmsDepartment.all
    respond_with(@cms_departments)
  end

  def show
    respond_with(@cms_department)
  end

  def new
    @cms_department = CmsDepartment.new
    respond_with(@cms_department)
  end

  def edit
  end

  def create
    @cms_department = CmsDepartment.new(cms_department_params)
    @cms_department.save
    respond_with(@cms_department)
  end

  def update
    @cms_department.update(cms_department_params)
    respond_with(@cms_department)
  end

  def destroy
    @cms_department.destroy
    respond_with(@cms_department)
  end

  private
    def set_cms_department
      @cms_department = CmsDepartment.find(params[:id])
    end

    def cms_department_params
      params.require(:cms_department).permit(:title, :content, :image, :kind)
    end
end
