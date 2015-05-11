class HomeNotificationsController < HomeController
  def index
  	@articles = CmsArticle.notices
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end
end
