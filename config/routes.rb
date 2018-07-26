Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  root "pages#show", page: "home"
  get "pages/:page" => "pages#show"
  get "/signup_user", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
