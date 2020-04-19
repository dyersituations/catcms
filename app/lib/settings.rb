require 'singleton'

# The singleton for admin settings.
# Handles saving and loading admin settings.
class Settings
  include Singleton

  # Default settings.
  ADMIN_PASS = "******"
  IS_ADMIN_PASS = false
  SITE_NAME = 'CatCMS'
  NAVBAR_BG_COLOR = '#343a40'
  NAVBAR_FONT_COLOR = '#fff'
  PAGE_BG_COLOR = '#fff'
  PAGE_FONT_COLOR = '#000'
  COPYRIGHT_NAME = ''
  GALLERY_CAPTIONS = false;

  # Checks the passed-in password against the saved admin salt and hash.
  def admin_authenticate?(password)
    salt = get_setting(:admin_pass_salt, '')
    hash = get_setting(:admin_pass_hash, '')
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
    save_setting(:copyright_name, params[:copyright_name])
    save_setting(:gallery_captions, params[:gallery_captions])
  end

  # Whether an admin pass has been saved.
  # Admin page is public until a password is saved.
  def is_admin_pass
    get_setting(:is_admin_pass, IS_ADMIN_PASS)
  end

  # The name of the site, used both in the page title and navbar.
  def site_name
    get_setting(:site_name, SITE_NAME)
  end

  # The background color of the navbar.
  def navbar_bg_color
    get_setting(:navbar_bg_color, NAVBAR_BG_COLOR)
  end

  # The font color of the navbar, hamburger menu color, and bottom border color.
  def navbar_font_color
    get_setting(:navbar_font_color, NAVBAR_FONT_COLOR)
  end

  # The background color of the page.
  def page_bg_color
    get_setting(:page_bg_color, PAGE_BG_COLOR)
  end

  # The font color of the page.
  def page_font_color
    get_setting(:page_font_color, PAGE_FONT_COLOR)
  end

  # The name used for the copyright in the footer.
  def copyright_name
    get_setting(:copyright_name, COPYRIGHT_NAME)
  end

  # Whether to display the post titles under the thumbnails in the galleries.
  def gallery_captions
    get_setting(:gallery_captions, GALLERY_CAPTIONS)
  end

  # Gets all of the settings.
  def get_settings
    OpenStruct.new(
      :is_admin_pass => is_admin_pass,
      :site_name => site_name,
      :navbar_bg_color => navbar_bg_color,
      :navbar_font_color => navbar_font_color,
      :page_bg_color => page_bg_color,
      :page_font_color => page_font_color,
      :copyright_name => copyright_name,
      :gallery_captions => gallery_captions
    )
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
