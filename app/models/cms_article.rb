class CmsArticle < ActiveRecord::Base
	mount_uploader :image, CmsArticleUploader
	#default_scope  { where("kind!=100") }

	def self.articles
		where("kind=0")
	end

	def self.notices
		where("kind=10")
	end

	def self.dang_articles
		CmsArticle.unscoped.where("kind=100")
	end
end
