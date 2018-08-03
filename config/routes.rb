Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  root "pages#show", page: "home"
  get "password_resets/new"
  get "password_resets/edit"
  get "pages/:page" => "pages#show"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :doctors
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :questions, concerns: :paginatable
  resources :answers, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :edit, :destroy, :update]

  namespace :admin do
    get "/", to: "dashboards#index"
    resources :doctors
    resources :users, only: [:index, :update]
    resources :questions, only: [:index, :destroy]
    resources :answers, only: [:index, :destroy]
    resource :block_users, only: [:create, :destroy]
    resource :activate_doctors, only: [:create]
  end

  mount ActionCable.server => "/cable"
end
