class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authorize
    if !session[:admin]
      redirect_to admin_path
    end
  end

  def load_pages
    @pages = Page.all
  end
end
