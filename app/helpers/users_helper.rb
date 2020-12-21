module UsersHelper
  def users_url(opts = {})
    users_path({only_path: false}.reverse_merge(opts))
  end
  def users_path(opts = {})
    url_for({controller: "users", action: "index"}.reverse_merge(opts))
  end
  
  def edit_user_path(id, opts = {})
    url_for({controller: "users", action: "edit", id: id.to_param}.reverse_merge(opts))
  end
  def user_path(id, opts = {})
    url_for({controller: "users", action: "show", id: id.to_param}.reverse_merge(opts))
  end
end
