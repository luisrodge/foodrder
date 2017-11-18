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
    get 'admin/login', to: 'sessions#new', as: :new_user_session
    post 'admin/login', to: 'sessions#create', as: :user_session
  end

  # Seller only routes
  namespace :seller do
    resource :dashboard, only: :show
    resources :menus do
      resources :foods, only: [:new, :create]
    end
    resources :foods
  end

  # Customer only routes
  namespace :customer do
    resource :dashboard, only: :show
  end

  # Admin only routes
  namespace :admin do
    resource :dashboard, only: :show
    resources :restaurants do
      resources :menus, only: [:new, :create]
    end
    resources :orders
    resources :order_fragments, only: :update
    resources :order_archives, only: [:index, :show]
    resources :restaurant_requests
    resources :menus do
      resources :foods, only: [:new, :create]
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

  resources :orders, only: [:nil] do
    resource :confirmation_number, only: :show
  end

  resources :restaurants
  resources :restaurant_requests, only: [:new, :create]
  resources :foods
  resources :menu_categories, only: :index

  resource :search, only: :show

  get 'about', to: 'pages#about'

end
