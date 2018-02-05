class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authorize
    if !Settings.instance.admin_pass && params[:controller] != 'admin'
      redirect_to admin_path
    elsif !session[:admin] && Settings.instance.admin_pass && params[:action] != 'login'
      session[:login_redirect] = request.original_url
      redirect_to login_path
    end
  end

  def load_pages
    @pages = Page.all
  end
end
