Rails.application.routes.draw do

  root to: 'restaurants#index'
=begin
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
=end

  # Web-based authentication routes for supplier
  devise_for :supplier, controllers: {
      registrations: 'supplier/registrations',
      sessions: 'supplier/sessions'
  }
  # Authentication routes for admin
  devise_for :admin, controllers: {registrations: 'admin/registrations', sessions: 'admin/sessions'}

  # Seller only routes
  namespace :supplier do
    resource :dashboard, only: :show
    resources :reservations
    resources :foods
    resources :archives
    resources :menus do
      resources :foods, only: [:new, :create]
    end
    resources :order_fragments do
      member do
        put :archive
        put :order_ready
      end
    end
    namespace :settings do
      resource :profile, only: [:edit, :update]
    end
  end

  # Admin only routes
  namespace :admin do
    resource :dashboard, only: :show
    resources :restaurants do
      resources :schedules
      resources :menus, only: [:new, :create]
      resources :specials
      resources :drinks
      resources :message_numbers
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
    resources :reservations
  end

  resources :restaurants do
    resources :reservations
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

  namespace :info do
    get 'customers', to: 'pages#customers'
    get 'restaurants', to: 'pages#restaurants'
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
