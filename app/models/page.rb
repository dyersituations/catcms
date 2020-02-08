class Page < ActiveRecord::Base
  mount_uploader :banner, BannerUploader
  before_save :cap_path
  after_save :empty_oid

  PAGETYPES = { :PLAIN => 0, :HOME => 1, :BLOG => 2, :GALLERY => 3 }

  private

  def cap_path
    self.path = self.path.downcase.split.map(&:capitalize)*''
  end

  def empty_oid
    # Uploader adds OID even without an image file.
    if self.banner.file.nil?
      self.update_column(:banner, nil)
    end
  end
end
