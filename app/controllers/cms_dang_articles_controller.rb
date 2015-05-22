class CmsDangArticlesController < ApplicationController
  load_and_authorize_resource :class => "CmsArticle"
  before_action :set_cms_article, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def index
    @cms_articles = CmsArticle.dang_articles
    respond_with(@cms_articles)
  end

  def show
    respond_with(@cms_article)
  end

  def new
    @cms_article = CmsArticle.new
    respond_with(@cms_article)
  end

  def edit
  end

  def create
    @cms_article = CmsArticle.new(cms_article_params)
    @cms_article.save
    respond_with(@cms_article,location: cms_dang_article_path(@cms_article))
  end

  def update
    @cms_article.update(cms_article_params)
    respond_with(@cms_article,location: cms_dang_article_path(@cms_article))
  end

  def destroy
    @cms_article.destroy
    respond_with(@cms_article,location: cms_dang_articles_path)
  end

  private
    def set_cms_article
      @cms_article = CmsArticle.find(params[:id])
    end

    def cms_article_params
      params.require(:cms_article).permit(:title, :content, :image,:is_recommend,:kind)
    end
end
