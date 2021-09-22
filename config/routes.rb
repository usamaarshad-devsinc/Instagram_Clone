# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search', to: 'public#search'
  resources :requests, only: %i[create update destroy]
  resources :stories, except: %i[edit update]
  get 'profile', to: 'public#profile'

  root 'posts#index'
  resources :posts, shallow: true do
    resources :comments, except: %i[index new show]
    resources :likes, only: %i[create destroy]
  end
end
