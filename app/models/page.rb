class Page < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  before_save :cap_path

  PAGETYPES = { :PLAIN => 0, :HOME => 1, :BLOG => 2, :GALLERY => 3 }

  private

  def cap_path
    self.path = self.path.split.map(&:capitalize)*' '
  end
end
