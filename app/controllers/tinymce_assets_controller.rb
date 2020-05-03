class TinymceAssetsController < ApplicationController
  def create
    p 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
    begin
      image = EditorImage.create(params.permit(:file, :alt))
    rescue StandardError => e
      p "WWWWWWWWWWWWWWWWWWWWWWWWWWWW"
      p e.message
      p e.backtrace.inspect
    end
    render json: {
      image: {
        url: image.file.url,
      },
    }, content_type: "text/html"
  end
end
