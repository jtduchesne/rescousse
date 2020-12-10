Rails.application.routes.draw do
  resources :places, except: [:new]
  
  scope "(:locale)/", locale: /fr|en/ do
    root to: 'home#index', format: false
  end
end
