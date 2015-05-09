class CmsArticle < ActiveRecord::Base
	mount_uploader :image, AttacheUploader
	#default_scope  { where("kind!=100") }

	def self.articles
		where("kind!=100")
	end

	def self.dang_articles
		CmsArticle.unscoped.where("kind=100")
	end
end
