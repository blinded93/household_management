Rails.application.routes.draw do
  root 'welcome#home'
  get '/join' => 'households#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :households, only: [:show, :create, :edit, :update, :destroy] do
    get 'control' => 'households#control'
    resources :members
    resources :rooms
    resources :bills
  end

  resources :lists, only: [:create, :update, :destroy]
  resources :items, only: [:create, :update, :destroy]
end
