Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "pages/:page" => "pages#show"
  get "/signup_user", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  resources :users
end
