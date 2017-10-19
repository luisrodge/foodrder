Rails.application.routes.draw do
  root to: 'pages#home'

  # Custom registration routes for customers and admins
  devise_for :customers, controllers: { registrations: 'customer/registrations' }, skip: :sessions
  devise_for :sellers, controllers: { registrations: 'seller/registrations' }, skip: :sessions
  devise_for :admins, controllers: { registrations: 'admin/registrations' }, skip: :sessions

  # Single sign in route for customers, sellers, and admins
  devise_for :users, controllers: { sessions: 'sessions' }, skip: %i[sessions registrations]
  as :user do
    delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
    get 'login', to: 'sessions#new', as: :new_user_session
    post 'login', to: 'sessions#create', as: :user_session
  end
end
