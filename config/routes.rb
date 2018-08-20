Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    confirmations: "users/confirmations"
  }

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  root "pages#show", page: "home"
  get "password_resets/new"
  get "password_resets/edit"
  get "pages/:page" => "pages#show"

  resources :users
  resources :doctors
  resources :account_activations, only: [:edit]
  resource :likes, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :questions, concerns: :paginatable
  resources :answers, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :edit, :destroy, :update]
  resources :searchs, only: [:index, :show]
  resources :diseases, only: [:index, :show]
  resources :medicine_classes, only: [:index]
  resources :medicine_types, only: [:show]
  resources :medicines, only: [:show]
  resources :notifications, only: [:update] do
    post :mark_all_as_checked, on: :collection
  end
  resources :bookings, only: [:create, :update, :destroy]
  resources :schedules, only: [:index]

  resources :conversations do
    member do
      post :close
    end
    resources :messages
  end

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
