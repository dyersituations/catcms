class Post < ActiveRecord::Base
  attr_accessible :content, :image, :title, :page_path
  
  mount_uploader :image, PostUploader
end