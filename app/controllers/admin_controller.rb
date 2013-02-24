class AdminController < ApplicationController
  before_filter :load_pages, :only => :admin

  def admin
    if (session[:admin])
      redirect_to root_path
    end
  end
  
  def login
    if (BCrypt::Password.new(APP_CONFIG['admin_pass']) == params[:admin_pass])
      session[:admin] = true
      redirect_to root_path
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
