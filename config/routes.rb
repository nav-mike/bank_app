Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users
  resource :user_session
  resources :money_transfers, only: [:new, :create]

  root 'users#show'
end
