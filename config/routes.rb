Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  get 'pages/home', to: "pages#home"

  resources :recipes do
    resources :comments, only: [:create,:edit,:update,:destroy]
    resources :likes, only: [:create, :destroy]
  end

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  resources :ingredients

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'

  resources :messages, only: [:create]
end
