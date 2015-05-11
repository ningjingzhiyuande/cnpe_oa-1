class HomeDangArticlesController < HomeController
   def index
  	@articles = CmsArticle.articles
  end

  def show
  	@article = CmsArticle.find(params[:id])
  end

  def lianjies
  	 @articles = CmsDangqun.all
  end
end
