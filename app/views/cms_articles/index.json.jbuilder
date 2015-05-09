json.array!(@cms_articles) do |cms_article|
  json.extract! cms_article, :id, :title, :content, :image
  json.url cms_article_url(cms_article, format: :json)
end
