Rails.application.routes.draw do
  resources :line_items
  resources :carts

devise_for :users

resources :products do
  member do
    post 'add_to_cart'
  end
end

devise_scope :user do
  get 'signup', to: 'devise/registrations#new'
  get 'login', to: 'devise/sessions#new'
  get 'logout', to: 'devise/sessions#destroy'
end
root 'main#graf'

get 'contact', to: 'contact#follow', as: 'contact'
get 'product', to: 'product#index', as: 'products_list'
end





