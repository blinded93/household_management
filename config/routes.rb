Rails.application.routes.draw do
  root 'welcome#home'
  get '/join/complete' => 'welcome#complete'
  get '/join' => 'members#new', as: :join
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch '/chores/:id/complete' => 'chores#complete', as: :complete_chore
  delete '/chores/clear' => 'chores#destroy', as: :clear_chores
  get '/households/join' => 'households#join', as: :join_household_modal
  post '/households/join' => 'households#join_household', as: :join_household
  patch '/bills/:id/pay' => 'bills#pay', as: :pay_household_bill

  resources :households, except: [:index] do
    get '/calendar/day' => 'calendar#day'
    get '/calendar/load' => 'calendar#load'
    get 'control' => 'households#control'
    resources :members, except: [:show]
    get '/members/reload' => 'members#reload'
    resources :rooms, except: [:index]
    get '/room_items/reload' => 'room_items#reload'
    resources :bills, except: [:index]
    get '/chores/reload' => 'chores#reload'
    resources :chores, except: [:index]
    resources :list_items, only: [:destroy]
    get '/list_items/reload' => 'list_items#reload'
    resources :room_items, except: [:index]
  end

  resources :members, only: [:create]
  resources :members, only: [:show] do
    get '/chores/reload' => 'chores#reload'
    get '/messages/inbox' => 'messages#inbox', as: :inbox
    get '/messages/check' => 'messages#check', as: :check_messages
    post '/messages/reply' => 'messages#reply'
    resources :messages, except: [:index, :update]
    get '/list_items/reload' => 'list_items#reload'
    resources :list_items, except: [:index]
    patch 'request/room_item/:id' => 'room_items#inventory_request', as: :room_item_request
    get '/room_items/reload' => 'room_items#reload'
  end
end
