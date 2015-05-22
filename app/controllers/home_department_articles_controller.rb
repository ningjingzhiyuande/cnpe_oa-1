class HomeDepartmentArticlesController < HomeController
  def index
  	@articles = CmsArticle.articles.page(params[:page]).per(15)
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end
end
