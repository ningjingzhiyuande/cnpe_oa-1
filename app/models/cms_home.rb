class CmsHome < ActiveRecord::Base
	enum kind: [:lunbotu,:tonggao,:bumenjianjie,:youqinglianjie,:tongzhi]
	mount_uploader :image,AttacheUploader
end
