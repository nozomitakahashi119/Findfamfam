Rails.application.routes.draw do
  root to: 'sessions#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :requestings
      get :requesters
      get :likes
    end
  end
  
  post '/permit_share', to: 'shares#permit_share'
  delete '/unpermit_share', to: 'shares#unpermit_share'
  get '/users/:id/index', to: 'houses#my_index'
  get '/users/:id/request', to: 'houses#my_request_index'
  
  resources :houses, only: [:index, :show, :new, :create, :destroy]
  #micropostsの時はindex,showがusersと紐付けてusersで表示するためいらなかった
  resources :shares, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end