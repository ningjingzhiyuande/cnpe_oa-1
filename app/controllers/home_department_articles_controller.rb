class HomeDepartmentArticlesController < HomeController
  def index
  	@articles = CmsArticle.articles
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end
end
