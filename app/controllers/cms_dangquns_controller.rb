class CmsDangqunsController < ApplicationController
  before_action :set_cms_dangqun, only: [:show, :edit, :update, :destroy,:download]
  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def index
    @cms_dangquns = CmsDangqun.all
    respond_with(@cms_dangquns)
  end

  def show
    respond_with(@cms_dangqun)
  end

  def new
    @cms_dangqun = CmsDangqun.new
    respond_with(@cms_dangqun)
  end

  def edit
  end

  def create
    @cms_dangqun = CmsDangqun.new(cms_dangqun_params)
    @cms_dangqun.save
    respond_with(@cms_dangqun)
  end

  def update
    @cms_dangqun.update(cms_dangqun_params)
    respond_with(@cms_dangqun)
  end
 
  def download
  	send_file "#{Rails.root}/public#{@cms_dangqun.document_url}"
  end
  def destroy
    @cms_dangqun.destroy
    respond_with(@cms_dangqun)
  end

  private
    def set_cms_dangqun
      @cms_dangqun = CmsDangqun.find(params[:id])
    end

    def cms_dangqun_params
      params.require(:cms_dangqun).permit(:title, :document,:is_recommend)
    end
end
