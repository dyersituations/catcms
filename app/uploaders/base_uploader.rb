class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :postgresql_lo
  process :fix_exif_rotation

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Resets the orientation of the uploaded image.
  # By default CarrierWave was rotating 90 degrees.
  def fix_exif_rotation 
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end
end