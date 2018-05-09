Rails.application.routes.draw do
  root 'static_pages#home'                      # => root_path
  get  '/help',    to: 'static_pages#help'      # => help_path
  get  '/about',   to: 'static_pages#about'     # => about_path
  get  '/contact', to: 'static_pages#contact'   # => contact_path
  get  '/signup',  to: 'users#new'              # => signup_path
  resources :users
end
