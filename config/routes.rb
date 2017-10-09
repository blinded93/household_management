Rails.application.routes.draw do
  root 'welcome#home'
  get '/join' => 'households#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/chores/complete' => 'chores#complete'

  resources :households, only: [:show, :create, :edit, :update, :destroy] do
    get 'control' => 'households#control'
    resources :members, except: [:show]
    resources :rooms
    resources :bills
    get '/chores/:scope' => 'chores#index'
  end

  resources :members, only: [:show] do
    get '/chores/:scope' => 'chores#index'
    get '/messages/inbox' => 'messages#inbox'
    get '/messages/sent' => 'messages#sent'
    resources :messages, only: [:new, :create, :destroy]
  end
  resources :chores, only: [:new, :create, :edit, :update, :destroy]
  resources :lists, only: [:edit, :update, :destroy]
  resources :items, only: [:create, :edit, :update, :destroy]
end
