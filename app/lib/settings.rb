require 'singleton'

class Settings
  include Singleton

  def admin_authenticate?(password)
    salt = get_setting(:admin_pass_salt)
    hash = get_setting(:admin_pass_hash)
    hash == BCrypt::Engine.hash_secret(password, salt)
  end

  def save(params)
    save_admin_pass(params[:admin_pass])
    save_setting(:site_name, params[:site_name])
    save_setting(:bar_bg_color, params[:bar_bg_color])
    save_setting(:bar_font_color, params[:bar_font_color])
    save_setting(:page_bg_color, params[:page_bg_color])
    save_setting(:copyright_name, params[:copyright_name])
    save_setting(:copyright_color, params[:copyright_color])
    save_setting(:gallery_captions, params[:gallery_captions])
  end

  def admin_pass
    get_setting(:admin_pass_exists, false)
  end

  def site_name
    get_setting(:site_name, 'CatCMS')
  end

  def bar_bg_color
    get_setting(:bar_bg_color, '#400000')
  end

  def bar_font_color
    get_setting(:bar_font_color, '#000')
  end

  def page_bg_color
    get_setting(:page_bg_color, '#DAB47D')
  end

  def copyright_name
    get_setting(:copyright_name)
  end

  def copyright_color
    get_setting(:copyright_color, '#000')
  end

  def gallery_captions
    get_setting(:gallery_captions)
  end

  private

  def get_setting(key, default = '')
    setting = Setting.where(key: key).first
    setting ? setting.value : default
  end

  def save_setting(key, val)
    if val != ''
      setting = Setting.where(key: key).first_or_create
      setting.value = val
      setting.save
    end
  end

  def save_admin_pass(val)
    pass_salt = BCrypt::Engine.generate_salt
    pass_hash = BCrypt::Engine.hash_secret(val, pass_salt)
    save_setting(:admin_pass_salt, pass_salt)
    save_setting(:admin_pass_hash, pass_hash)
    save_setting(:admin_pass_exists, true)
  end
end
