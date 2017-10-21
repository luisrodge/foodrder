Rails.application.routes.draw do

  root to: 'pages#home'

  # Custom registration routes for customer and admins
  devise_for :customer, controllers: {registrations: 'customer/registrations' }, skip: :sessions
  devise_for :sellers, controllers: { registrations: 'seller/registrations' }, skip: :sessions
  devise_for :admins, controllers: { registrations: 'admin/registrations' }, skip: :sessions

  # Single sign in route for customer, sellers, and admins
  devise_for :users, controllers: { sessions: 'sessions' }, skip: %i[sessions registrations]
  as :user do
    delete 'sign_out', to: 'sessions#destroy', as: :destroy_user_session
    get 'sign_in', to: 'sessions#new', as: :new_user_session
    post 'sign_in', to: 'sessions#create', as: :user_session
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

  # Customer only routes
  namespace :admin do
    resource :dashboard, only: :show
    resources :restaurants
  end

  resource :cart, only: :show
  resources :cart_items

  # Cart checkout
  resources :cart, only: [:nil]  do
    resources :checkouts
  end

  resources :restaurants

end
