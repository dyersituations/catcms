class Page < ActiveRecord::Base
  attr_accessible :page_type, :path, :banner, :title, :content
  
  mount_uploader :banner, BannerUploader

  PAGETYPES = { :PLAIN => 1, :BLOG => 2, :GALLERY => 3 }
end
