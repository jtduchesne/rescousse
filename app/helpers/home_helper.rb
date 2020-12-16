module HomeHelper
  def root_url(opts = {})
    root_path({only_path: false}.reverse_merge(opts))
  end
  def root_path(opts = {})
    url_for({controller: "home", action: "index"}.reverse_merge(opts))
  end 
end