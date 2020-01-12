class PostUploader < BaseUploader
  process :resize_to_fit => [650, 650]
end
