Rails.application.routes.draw do
  root 'welcome#home'
  get '/join' => 'households#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/chores/complete' => 'chores#complete'
  get '/chores/:scope' => 'chores#index'
  resources :households, only: [:show, :create, :edit, :update, :destroy] do
    get 'control' => 'households#control'
    resources :members
    resources :rooms
    resources :bills
  end

  resources :chores, only: [:new, :create, :edit, :update, :destroy]
  resources :lists, only: [:edit, :update, :destroy]
  resources :items, only: [:create, :edit, :update, :destroy]
end
