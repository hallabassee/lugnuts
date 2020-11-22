Rails.application.routes.draw do
  get 'store/index'
  resources :line_items
  get 'delete_line_items', to: 'line_items#delete_all'
  resources :carts
  get 'shared/subscribers'
  resources :categories
	resources :posts do
		resources :comments
	  end
	  resources :comments do
		resources :comments
	  end
	
	get 'history', to: 'comments#history'

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
	resources :subscribers
	resources :about
	resources :contacts
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
