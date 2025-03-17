Rails.application.routes.draw do
  devise_for :users

  root to: "pages#swipe"

  get "/profile/:id", to: "profiles#show", as: "profile"

  get "/matches", to: "matches#matches"
# ---
  patch 'update_radius', to: 'pages#update_radius'
# ---
  resources :users, only: [:show]

  resources :vinyles, except: [:index] do
    resources :matches, only: [:create]
  end
  resources :matches, only: :show do
    resources :messages, only: :create
  end

  resources :user_likes, only: [:create]
  resources :user_dislikes, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
