Rails.application.routes.draw do

 
  #resources :users
  
  devise_for :users, :defaults => { :format => 'json' }
  resources :users, except: [:new, :create], :defaults => { :format => 'json' }
  #resources :users
  root  'home#index', :defaults => { :format => 'json' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
