class HomeNotificationsController < HomeController
  def index
  	@articles = CmsArticle.notices.page(params[:page]).per(15)
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end
end
