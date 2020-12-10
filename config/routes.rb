Rails.application.routes.draw do
  scope locale: "fr", path_names: {new: "nouveau", edit: "modifier"} do
    resources :places, except: [:new], path: "endroits", as: "fr_places"
  end
  scope locale: "en" do
    resources :places, except: [:new], path: "places", as: "en_places"
  end
  
  scope "(:locale)/", locale: /fr|en/ do
    root to: 'home#index', format: false
  end
end
