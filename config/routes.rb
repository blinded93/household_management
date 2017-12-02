Rails.application.routes.draw do
  root 'welcome#home'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch '/chores/:id/complete' => 'chores#complete', as: :complete_chore
  delete '/chores/clear' => 'chores#destroy', as: :clear_chores

  resources :households, only: [:create, :update, :destroy] do
    # resource :calendar, only: [:show], controller: :calendar
    get 'control' => 'households#control'
    resources :members, except: [:show]
    resources :rooms, only: [:new, :create, :update, :destroy]
    resources :bills, only: [:create, :update, :destroy]
    resources :chores, only: [:create, :update, :destroy]
  end

  resources :members, only: [:show] do
    get '/messages/inbox' => 'messages#inbox', as: :inbox
    resources :messages, only: [:create, :destroy]
  end
  resources :list_items, only: [:create, :update, :destroy]
  post 'request/room_item/:id' => 'room_items#inventory_request', as: :room_item_request
  resources :room_items, only: [:create, :update, :destroy]
end
