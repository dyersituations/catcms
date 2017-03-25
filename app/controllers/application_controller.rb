class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authorize
    if !session[:admin]
      session[:login_redirect] = request.original_url
      redirect_to login_path
    end
  end

  def load_pages
    @pages = Page.all
  end
end
