class AdminController < ApplicationController
  before_action :authorize, :except => [:login, :login_admin]
  before_action :load_pages, :only => [:login, :admin]

  def save
    if params[:admin_pass]
      Settings.instance.admin_pass = params[:admin_pass]
    end
    Settings.instance.gallery_captions = params[:gallery_captions]
    redirect_to admin_path
  end

  def login_admin
    if (Settings.instance.admin_authenticate?(params[:admin_pass]))
      session[:admin] = true
      login_redirect = session[:login_redirect]
      session.delete(:login_redirect)
      redirect_to login_redirect ? login_redirect : root_path
    else
      flash[:error] = 'Admin password incorrect! Please try again.'
      redirect_to admin_path
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end
end
