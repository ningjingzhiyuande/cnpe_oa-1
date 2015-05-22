class CmsHomesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cms_home, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:destroy]
  def index
    @cms_homes = CmsHome.where("kind=?",params[:kind].to_i)
    @cms_home = CmsHome.new
    respond_with(@cms_homes)
  end

  def show
    respond_with(@cms_home)
  end

  def new
    @cms_home = CmsHome.new
    respond_with(@cms_home)
  end

  def edit
  end

  def create
    @cms_home = CmsHome.new(cms_home_params)
    @cms_home.save
    redirect_to :back
  end

  def update
    @cms_home.update(cms_home_params)
    respond_with(@cms_home)
  end

  def destroy
    @cms_home.destroy
    redirect_to :back
  end

  private
    def set_cms_home
      @cms_home = CmsHome.find(params[:id])
    end

    def cms_home_params
      params.require(:cms_home).permit(:title, :url, :image, :content,:kind)
    end
end
