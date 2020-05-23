require "singleton"

# The singleton for admin settings.
# Handles saving and loading admin settings.
class Settings
  include Singleton

  # Default settings.
  ADMIN_PASS = "******"
  IS_ADMIN_PASS = false
  SITE_NAME = "CatCMS"
  NAVBAR_BG_COLOR = "#343a40"
  NAVBAR_FONT_COLOR = "#fff"
  PAGE_BG_COLOR = "#fff"
  PAGE_FONT_COLOR = "#000"
  SUBNAV_BG_COLOR = "#6c757d"
  SUBNAV_FONT_COLOR = "#fff"
  COPYRIGHT_NAME = ""
  GALLERY_CAPTIONS = false

  # Checks the passed-in password against the saved admin salt and hash.
  def admin_authenticate?(password)
    salt = get_setting(:admin_pass_salt, "")
    hash = get_setting(:admin_pass_hash, "")
    hash == BCrypt::Engine.hash_secret(password, salt)
  end

  # Saves all of the settings using the passed-in params.
  def save(params)
    save_admin_pass(params[:admin_pass])
    save_setting(:site_name, params[:site_name])
    save_setting(:navbar_bg_color, params[:navbar_bg_color])
    save_setting(:navbar_font_color, params[:navbar_font_color])
    save_setting(:page_bg_color, params[:page_bg_color])
    save_setting(:page_font_color, params[:page_font_color])
    save_setting(:subnav_bg_color, params[:subnav_bg_color])
    save_setting(:subnav_font_color, params[:subnav_font_color])
    save_setting(:copyright_name, params[:copyright_name])
    save_setting(:gallery_captions, params[:gallery_captions])
  end

  # Admin page is public until a password is saved.
  def is_admin_pass
    get_setting(:is_admin_pass, IS_ADMIN_PASS)
  end

  def site_name
    get_setting(:site_name, SITE_NAME)
  end

  def navbar_bg_color
    get_setting(:navbar_bg_color, NAVBAR_BG_COLOR)
  end

  def navbar_font_color
    get_setting(:navbar_font_color, NAVBAR_FONT_COLOR)
  end

  def page_bg_color
    get_setting(:page_bg_color, PAGE_BG_COLOR)
  end

  def page_font_color
    get_setting(:page_font_color, PAGE_FONT_COLOR)
  end

  def subnav_bg_color
    get_setting(:subnav_bg_color, SUBNAV_BG_COLOR)
  end

  def subnav_font_color
    get_setting(:subnav_font_color, SUBNAV_FONT_COLOR)
  end

  def copyright_name
    get_setting(:copyright_name, COPYRIGHT_NAME)
  end

  def gallery_captions
    get_setting(:gallery_captions, GALLERY_CAPTIONS)
  end

  def get_settings
    OpenStruct.new(
      :is_admin_pass => is_admin_pass,
      :site_name => site_name,
      :navbar_bg_color => navbar_bg_color,
      :navbar_font_color => navbar_font_color,
      :page_bg_color => page_bg_color,
      :page_font_color => page_font_color,
      :subnav_bg_color => subnav_bg_color,
      :subnav_font_color => subnav_font_color,
      :copyright_name => copyright_name,
      :gallery_captions => gallery_captions,
    )
  end

  def lighten_color(hex_color, amount = 0.4)
    hex_color = hex_color.gsub("#", "")
    rgb = hex_color.scan(/../).map { |color| color.hex }
    rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
    rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
    rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
    "#%02x%02x%02x" % rgb
  end

  private

  # Gets the value of the setting with the passed-in key, otherwise, default.
  def get_setting(key, default)
    setting = Setting.where(key: key).first
    setting ? setting.value : default
  end

  # Saves the settings with the passed-in key and val.
  def save_setting(key, val)
    # Check for nil, since unchecked checkboxes don't sent a value.
    # Check for whether a boolean, since .blank? returns true for false.
    # Check for a blank string.
    if val == nil || !!val == val || !val.blank?
      setting = Setting.where(key: key).first_or_create
      setting.value = val
      setting.save
    end
  end

  # Saves the admin password salt, hash, and whether the password exists.
  def save_admin_pass(val)
    if val != ADMIN_PASS
      pass_salt = BCrypt::Engine.generate_salt
      pass_hash = BCrypt::Engine.hash_secret(val, pass_salt)
      save_setting(:admin_pass_salt, pass_salt)
      save_setting(:admin_pass_hash, pass_hash)
      save_setting(:is_admin_pass, true)
    end
  end
end
