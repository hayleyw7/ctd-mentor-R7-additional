Rails.application.routes.draw do
  root to: 'customers#index'

  get 'customers/index', to: 'customers#index', as: 'customers_index'

  resources :customers do
    member do
      delete :destroy_with_orders
    end
  end

  resources :orders
end
