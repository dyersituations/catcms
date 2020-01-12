class ThumbnailUploader < BaseUploader
  process :resize_to_fill => [205, 205, 'North']
end