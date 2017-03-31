Rails.application.routes.draw do




 
  resources :comment_products
  #resources :users
  
  devise_for :users, :defaults => { :format => 'json' }
  resources :users, except: [:new, :create], :defaults => { :format => 'json' }
  #resources :users
  root  'home#index', :defaults => { :format => 'json' }
  resources :companies
  resources :images
  resources :sales
  resources :transactions
  resources :carts
 # resources :categories
  resources :products
  resources :publications
  resources :comment_publications
#>>>>>>> "creating_categories"

  resources :comment_products
  resources :category_products
  resources :categories
  #resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
