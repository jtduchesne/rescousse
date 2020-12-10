module PlacesHelper
  def places_url(opts = {})
    places_path({only_path: false}.reverse_merge(opts))
  end
  def places_path(opts = {})
    url_for({controller: "places", action: "index"}.reverse_merge(opts))
  end
  
  def edit_place_path(id, opts = {})
    url_for({controller: "places", action: "edit", id: id.to_param}.reverse_merge(opts))
  end
  def place_path(id, opts = {})
    url_for({controller: "places", action: "show", id: id.to_param}.reverse_merge(opts))
  end
end
