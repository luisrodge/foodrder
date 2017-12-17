Rails.application.routes.draw do
  root to: 'pages#home'

  # Custom registration routes for customer and admins
  devise_for :customer, controllers: {registrations: 'customer/registrations'}, skip: :sessions
  devise_for :sellers, controllers: {registrations: 'seller/registrations'}, skip: :sessions
  devise_for :admins, controllers: {registrations: 'admin/registrations'}, skip: :sessions

  # Single sign in route for customer, sellers, and admins
  devise_for :users, controllers: {sessions: 'sessions'}, skip: %i[sessions registrations]
  as :user do
    delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
    get 'login', to: 'sessions#new', as: :new_user_session
    post 'login', to: 'sessions#create', as: :user_session
  end

  # Seller only routes
  namespace :seller do
    resource :dashboard, only: :show
    resources :menus do
      resources :foods, only: [:new, :create]
    end
    resources :foods
    resources :order_fragments
    resources :archives
  end

  # Customer only routes
  namespace :customer do
    resource :dashboard, only: :show
  end

  # Admin only routes
  namespace :admin do
    resource :dashboard, only: :show
    resources :restaurants do
      resources :schedules
      resources :menus, only: [:new, :create]
      resources :specials
      resources :drinks
    end
    resources :schedules, only: [:edit, :update, :destroy]
    resources :tags, only: :index
    resources :subscribers
    resources :orders
    resources :order_fragments, only: :update
    resources :order_archives, only: [:index, :show]
    resources :restaurant_requests
    resources :foods, only: [:edit, :update, :destroy]
    resources :drinks, only: [:edit, :update, :destroy]
    resources :menus do
      resources :foods, only: [:new, :create]
    end
  end

  # API routes
  namespace :api do
    namespace :v1 do
      resources :foods, only: :show
      resources :drinks, only: :index
    end
  end

  # Customer cart
  resource :cart, only: :show
  resources :cart_items
  resources :cart_fragments

  # Cart checkout
  resources :cart, only: [:nil] do
    resources :checkouts
  end

  resources :restaurants do
    resources :drinks, only: :index
  end
  resources :restaurant_requests, only: [:new, :create]
  resources :foods, only: [:index, :show] do
    resources :cart_items, only: :create
  end
  resources :drinks, only: :nil do
    resources :cart_items, only: :create
  end
  resources :menu_categories, only: :index
  resources :subscribers, only: :create

  resource :search, only: :show

  get 'order_food', to: 'pages#order_food'
  get 'restaurant_info', to: 'pages#restaurant_info'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
