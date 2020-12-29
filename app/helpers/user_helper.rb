module UserHelper
  def login_path(opts = {})
    en? ? en_login_path(opts) : fr_login_path(opts)
  end
  def logout_path
    en? ? en_logout_path : fr_logout_path
  end
  
  def current_user_url(opts = {})
    current_user_path({only_path: false}.reverse_merge(opts))
  end
  def current_user_path(opts = {})
    url_for({controller: "user", action: "show"}.reverse_merge(opts))
  end
  def edit_current_user_path(opts = {})
    url_for({controller: "user", action: "edit"}.reverse_merge(opts))
  end
  
private
  def en?
    I18n.locale == :en
  end
end
