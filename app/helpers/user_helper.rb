module UserHelper
  def login_path(opts = {})
    en? ? en_login_path(opts) : fr_login_path(opts)
  end
  def logout_path
    en? ? en_logout_path : fr_logout_path
  end
  
private
  def en?
    I18n.locale == :en
  end
end
