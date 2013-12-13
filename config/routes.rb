KoombeaLibrary::Application.routes.draw do
  resources :pages, only: [:index]
  match 'auth/:provider/callback', to: 'sessions#create', via: :post
  get "logout", to: "sessions#destroy", as: "logout"
  root 'pages#index'

  resources :books do
    # this allow me to define an action called
    # 'search' in BooksController to mange
    # all the books search
    # having /books/search as url
    # and books_search_url and
    # books_search_path
    get 'search', on: :collection
  end
end
