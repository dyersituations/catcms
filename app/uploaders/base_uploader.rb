class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :postgresql_lo
  process :fix_exif_rotation
  after :store, :delete_tmp_dir

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

  # CarrierWave wasn't removing the uploads folder when adding a new page.
  def delete_tmp_dir(new_file)
    FileUtils.rm_rf(File.join(root, 'uploads'))
  end
end