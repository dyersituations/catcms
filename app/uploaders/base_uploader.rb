class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process :fix_exif_rotation
  after :store, :delete_tmp_dir

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def fix_exif_rotation
    # Resets the orientation of the uploaded image.
    # By default CarrierWave was rotating 90 degrees.
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  def delete_tmp_dir(new_file)
    # CarrierWave wasn't removing the uploads folder when adding a new page.
    FileUtils.rm_rf(File.join(root, "uploads", "tmp"))
  end
end
