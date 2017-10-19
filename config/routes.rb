Rails.application.routes.draw do
  root 'welcome#home'
  get '/join' => 'households#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch '/chores/:id/complete' => 'chores#complete', as: :complete_chores
  delete '/chores/clear' => 'chores#destroy', as: :clear_chores

  resources :households, only: [:show, :create, :edit, :update, :destroy] do
    get 'control' => 'households#control'
    resources :members, except: [:show]
    resources :rooms
    resources :bills
    resources :chores, only: [:new, :create, :edit, :update, :destroy]
    get '/chores/:scope' => 'chores#index'
  end

  resources :members, only: [:show] do
    get '/chores/:scope' => 'chores#index', as: :chores
    get '/messages/inbox' => 'messages#inbox', as: :inbox
    get '/messages/sent' => 'messages#sent', as: :sent_messages
    resources :messages, only: [:new, :create, :destroy]
  end
  resources :lists, only: [:edit, :update, :destroy]
  resources :items, only: [:create, :edit, :update, :destroy]
end
