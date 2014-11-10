KoombeaLibrary::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :pages, only: [:index]
  match 'auth/:provider/callback', to: 'sessions#create', via: :post
  get "logout", to: "sessions#destroy", as: "logout"
  root 'pages#index'
end
