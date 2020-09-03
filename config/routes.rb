Rails.application.routes.draw do
  resources :blogs
  root :to => "home#index"
end
