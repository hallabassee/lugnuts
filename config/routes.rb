Rails.application.routes.draw do
  root to: 'home#index'
  resources :products
  resources :productlines
  resources :payments
  resources :orders
  resources :orderdetails
  resources :offices
  resources :employees
  resources :customers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
