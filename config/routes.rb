Rails.application.routes.draw do
  get 'users/show'
  post 'create_order', to: 'orders#create_order'
  post 'capture_order', to: 'orders#capture_order'
  get 'payment_successful', to: 'orders#payment_successful'  
  post 'payment_successful', to: 'orders#payment_successful'
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

	devise_for :users, controllers: {
		registrations: 'users/registrations'}

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
