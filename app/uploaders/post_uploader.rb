class PostUploader < BaseUploader
  process :resize_to_fill => [650, 650]
end
