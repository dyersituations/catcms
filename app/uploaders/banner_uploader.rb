class BannerUploader < BaseUploader
  process :resize_to_fill => [2400, 300]
  after :store, :delete_tmp_dir

  private

  def delete_tmp_dir(new_file)
    # CarrierWave wasn't removing the uploads folder when adding a new page.
    FileUtils.rm_rf(File.join(root, "uploads"))
  end
end
