# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "public#homepage"
  get 'search', to: 'public#search'
  # resources :posts
  # resources :likes
  # resources :comments
  resources :requests
  resources :stories, only: %i[destroy create new show index]
  post 'privacy', to: 'requests#toggle_privacy'
  get 'profile', to: 'public#profile'

  root 'posts#index'
  resources :posts, shallow: true do
    resources :comments
    resources :likes
  end
end
