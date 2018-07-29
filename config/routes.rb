Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  root "pages#show", page: "home"
  get "pages/:page" => "pages#show"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :doctors
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    get "/", to: "dashboards#index"
    resources :doctors
  end
end
