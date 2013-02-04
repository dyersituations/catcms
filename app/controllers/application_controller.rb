class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?
  
  protected
  
  def authorize
    if APP_CONFIG['needs_auth'] && !admin?
      redirect_to admin_path
    end
  end
  
  def admin?
    session[:admin]
  end
end
