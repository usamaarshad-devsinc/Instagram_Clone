Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "public#homepage"
  get 'search', to: 'public#search'
  resources :posts
  resources :likes
  resources :comments
  resources :requests
  post 'privacy', to: 'requests#toggle_privacy'
end
