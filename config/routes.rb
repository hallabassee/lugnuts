Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :products
  resources :productlines
  resources :payments
  resources :orders
  resources :orderdetails
  resources :offices
  resources :employees
  resources :customers
  resources :articles
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
