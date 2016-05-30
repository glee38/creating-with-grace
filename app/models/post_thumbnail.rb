class PostThumbnail < ActiveRecord::Base
  belongs_to :post

  mount_uploader :thumbnail, PostThumbnailUploader
end
