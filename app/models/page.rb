class Page < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  mount_uploader :banner, BannerUploader

  PAGETYPES = { :PLAIN => 0, :BLOG => 2, :GALLERY => 3 }
end
