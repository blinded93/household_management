Rails.application.routes.draw do
  root 'welcome#home'
  get '/join' => 'members#new'
  resources :members, only: [:create]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :households, only: [:show, :new, :create, :edit, :update, :destroy] do
    get 'settings' => 'households#settings'
    resources :members
    resources :rooms
    resources :bills
  end

  resources :lists, only: [:create, :update, :destroy]
  resources :items, only: [:create, :update, :destroy]
end
