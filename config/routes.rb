Rails.application.routes.draw do
  scope "(:locale)/", locale: /fr|en/ do
    root to: 'home#index', format: false
  end
end
