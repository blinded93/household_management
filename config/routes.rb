Rails.application.routes.draw do
  root 'welcome#home'
  # get '/join' => 'households#new'
  # get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch '/chores/:id/complete' => 'chores#complete', as: :complete_chores
  delete '/chores/clear' => 'chores#destroy', as: :clear_chores

  resources :households, only: [:show, :create, :edit, :update, :destroy] do
    resource :calendar, only: [:show], controller: :calendar
    get 'control' => 'households#control'
    resources :members, except: [:show]
    get 'invitees/login' => 'invitees#login'
    post 'invitees/verify' => 'invitees#verify'
    resources :invitees, except: [:index]
    resources :rooms
    resources :bills
    resources :chores, except: [:index, :show]
  end

  resources :members, only: [:show] do
    get '/messages/inbox' => 'messages#inbox', as: :inbox
    get '/messages/sent' => 'messages#sent', as: :sent_messages
    resources :messages, only: [:new, :create, :show, :destroy]
  end
  resources :list_items, only: [:create, :update, :destroy]
  post 'request/room_item/:id' => 'room_items#inventory_request', as: :room_item_request
  resources :room_items, only: [:create, :update, :destroy]
end
