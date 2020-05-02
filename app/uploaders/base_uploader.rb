class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process :fix_exif_rotation
  after :store, :delete_tmp_dir
  after :remove, :remove_folder

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
    # CarrierWave doesn't remove the tmp folder when adding a new page.
    FileUtils.rm_rf(File.join(root, "uploads", "tmp"))
  end

  def remove_folder
    # CarrierWave doesn't remove the folder when the image is removed.
    FileUtils.remove_dir(File.join(root, store_dir), :force => true)
  end
end
