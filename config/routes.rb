Rails.application.routes.draw do
  root to: 'customers#index'

  get 'customers/index', to: 'customers#index', as: 'customers_index'
  delete "/customers/customerAndOrders/:id", to: "customers#destroy_with_orders"

  resources :customers
  resources :orders
end
