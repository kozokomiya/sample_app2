Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'                      # => root_path
  get  '/help',    to: 'static_pages#help'      # => help_path
  get  '/about',   to: 'static_pages#about'     # => about_path
  get  '/contact', to: 'static_pages#contact'   # => contact_path
  get  '/signup',  to: 'users#new'              # => signup_path

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
    # => GET /account_activations/:id/edit"
    # params[:id] <== 有効化トークン
    # Controller: params[:id]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
