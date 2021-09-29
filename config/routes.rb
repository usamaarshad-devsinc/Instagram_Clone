# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search', to: 'accounts#search'
  resources :requests, only: %i[create update destroy]
  resources :stories, except: %i[edit update]
  get 'profile', to: 'accounts#profile'

  root 'posts#index'
  resources :posts, shallow: true do
    delete 'delete_image/:id', to: 'posts#delete_image', as: :delete_image
    resources :comments, except: %i[index new show]
    post 'likes/', to: 'posts#create_like', as: 'likes'
    # resources :likes, only: %i[create destroy]
  end
  delete 'likes/:id', to: 'posts#destroy_like', as: 'unlike_post'
  # get '/*undefined', to: redirect('/404.html')
  get '/*undefined', to: redirect('posts#index')
end
