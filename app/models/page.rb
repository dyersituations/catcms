class Page < ActiveRecord::Base
  mount_uploader :banner, BannerUploader

  PAGETYPES = { :PLAIN => 0, :HOME => 1, :BLOG => 2, :GALLERY => 3 }
end
