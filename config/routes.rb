Rails.application.routes.draw do
  root 'welcome#home'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch '/chores/:id/complete' => 'chores#complete', as: :complete_chore
  delete '/chores/clear' => 'chores#destroy', as: :clear_chores

  resources :households, except: [:index] do
    get '/calendar/day' => 'calendar#day'
    get '/calendar/load' => 'calendar#load'
    get 'control' => 'households#control'
    resources :members, except: [:show]
    resources :rooms, except: [:index]
    resources :bills, except: [:index]
    get '/chores/reload' => 'chores#reload'
    resources :chores, except: [:index]
    resources :list_items, only: [:destroy]
    get '/list_items/reload' => 'list_items#reload'
    resources :room_items, except: [:index]
  end

  resources :members, only: [:show] do
    get '/chores/reload' => 'chores#reload'
    get '/messages/inbox' => 'messages#inbox', as: :inbox
    get '/messages/check' => 'messages#check', as: :check_messages
    post '/messages/reply' => 'messages#reply'
    resources :messages, except: [:index, :update]
    resources :list_items, except: [:index]
    post 'request/room_item/:id' => 'room_items#inventory_request', as: :room_item_request
  end
end
