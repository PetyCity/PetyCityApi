Rails.application.routes.draw do
  resources :coment_products
  resources :category_products
  resources :categories
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
