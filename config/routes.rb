Rails.application.routes.draw do

  # ROOT
  # =======================================================================================
  root 'shopper_reports#index'

  # SHOPPERS
  # =======================================================================================
  resources :shoppers

  # REPORTS
  # =======================================================================================
  get 'reports', to: 'shopper_reports#index'
  post 'reports', to: 'shopper_reports#create'
  get 'reports/:id', to: 'shopper_reports#show', as: 'report'
  delete 'reports/:id', to: 'shopper_reports#destroy'

  # SESSION MANAGEMENT
  # =======================================================================================
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#new'
  delete 'login', to: 'sessions#logout'

  # PRODUCT EDITS
  # =======================================================================================
  get 'product-edits', to: 'product_edits#index'
  post 'product-edits', to: 'product_edits#create'
  delete 'product_edits/:id', to: 'products_edits#destroy', as: 'product_edit'
  post 'product-edits/:id', to: 'product_edits#sync', as: 'product_edits_sync'

end
