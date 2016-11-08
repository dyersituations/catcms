class AdminController < ApplicationController
  before_action :load_pages, :only => :admin

  def save
    Settings.instance.admin_pass = params[:admin_pass]
    redirect_to admin_path
  end

  def login
    if (Settings.instance.admin_authenticate?(params[:admin_pass]))
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
