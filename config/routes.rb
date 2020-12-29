Rails.application.routes.draw do
  scope format: false do
    scope "/(:locale)", locale: /fr|en/ do
      root to: 'home#index'
    end
    
    get  "/auth/failure",            to: 'user#failure', as: "auth_failure"
    post "/auth/:provider",          to: 'user#new',     as: "auth"
    get  "/auth/:provider/callback", to: 'user#create',  as: "auth_callback"
  end
  
  scope locale: "fr", path_names: {new: "nouveau", edit: "modifier"} do
    resources :places, except: [:new], path: "endroits", as: "fr_places"
    resources :users, except: [:new], path: "utilisateurs", as: "fr_users"
    resource :user, controller: :user, only: [:show, :edit, :update], path: "utilisateur", as: "fr_current_user"
    
    get "/connexion",   to: 'user#new',     as: "fr_login"
    get "/déconnexion", to: 'user#destroy', as: "fr_logout"
  end
  scope locale: "en" do
    resources :places, except: [:new], path: "places", as: "en_places"
    resources :users, except: [:new], path: "users", as: "en_users"
    resource :user, controller: :user, only: [:show, :edit, :update], path: "user", as: "en_current_user"
    
    get "/login",  to: 'user#new',     as: "en_login"
    get "/logout", to: 'user#destroy', as: "en_logout"
  end
end
