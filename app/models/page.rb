class Page < ActiveRecord::Base
  attr_accessible :page_type, :path, :banner, :title, :header, :content
  
  mount_uploader :banner, BannerUploader

  PAGETYPES = { :HOME => 0, :PLAIN => 1, :BLOG => 2, :GALLERY => 3 }
end
