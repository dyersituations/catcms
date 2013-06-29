class Post < ActiveRecord::Base
  attr_accessible :content, :image, :title, :page_path, :tag
  
  mount_uploader :image, PostUploader
end