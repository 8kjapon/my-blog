Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#top"
  get "portfolio", to: 'pages#portfolio'
  resources :users, only: [:new, :create]
  # get 'signup', to: 'users#new'
  # post 'signup', to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  namespace :admin do
    root "dashboards#show"
    resource :dashboard, only: %i[show]
    resources :articles, only: %i[index new create edit update destroy]
    resources :static_pages, only: %i[index new create edit update destroy]
    post 'uploader', to: 'uploader#image'
  end
  resources :articles, only: %i[show]
end
