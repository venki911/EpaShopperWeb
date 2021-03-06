Rails.application.routes.draw do

  # ROOT
  # =======================================================================================
  root 'shopper_reports#index'

  # SHOPPERS
  # =======================================================================================
  resources :shoppers

  # SHOPPER ASSIGNMENTS
  # =======================================================================================
  get 'assignments', to: 'assignment_collections#index'
  post 'assignments', to: 'assignment_collections#create'
  get 'assignments/:id', to: 'assignment_collections#edit', as: 'assignment'
  post 'assignments/:id', to: 'assignment_collections#update'
  delete 'assignments/:id', to: 'assignment_collections#destroy'
  get 'assignments/:id/api', to: 'assignment_collections#edit_api'
  get 'get-assignment', to: 'assignment_collections#get_assignment'

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
  put 'product-edits/image/:id', to: 'product_edits#upload_image'
  delete 'product-edits/:id', to: 'product_edits#destroy', as: 'product_edit'
  post 'product-edits/:id', to: 'product_edits#sync', as: 'product_edits_sync'



end
