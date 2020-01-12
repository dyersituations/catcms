class Post < ActiveRecord::Base
  mount_uploader :image, PostUploader
  mount_uploader :thumbnail, ThumbnailUploader
end
