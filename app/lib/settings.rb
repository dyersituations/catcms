require 'singleton'

class Settings
  include Singleton

  def admin_pass
    get_setting(:admin_pass_exists).value
  end

  def admin_pass=(val)
    pass_salt = BCrypt::Engine.generate_salt
    pass_hash = BCrypt::Engine.hash_secret(val, pass_salt)
    save_setting(:admin_pass_salt, pass_salt)
    save_setting(:admin_pass_hash, pass_hash)
    save_setting(:admin_pass_exists, true)
  end

  def admin_authenticate?(password)
    salt = get_setting(:admin_pass_salt).value
    hash = get_setting(:admin_pass_hash).value
    hash == BCrypt::Engine.hash_secret(password, salt)
  end

  private

  def get_setting(key)
    Setting.where(key: key).first_or_create
  end

  def save_setting(key, val)
    @setting = get_setting(key)
    @setting.value = val
    @setting.save
  end
end
