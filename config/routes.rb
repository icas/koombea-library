KoombeaLibrary::Application.routes.draw do
  resources :pages, only: [:index]
  match 'auth/:provider/callback', to: 'sessions#create', via: :post
  get "logout", to: "sessions#destroy", as: "logout"
  root 'pages#index'

  resources :books
end
