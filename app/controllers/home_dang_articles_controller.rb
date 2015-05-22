class HomeDangArticlesController < HomeController
   def index
  	@articles = CmsArticle.articles.page(params[:page]).per(15)
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end

  def lianjies
  	 @articles = CmsDangqun.all.page(params[:page]).per(15)
  end
end
