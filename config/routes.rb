Rails.application.routes.draw do

  namespace :api do     
    namespace :v1 do 
       # devise_for :users, :defaults => { :format => 'json' }
         #get '/catego' => "categories#show_by_name"
        resources :users

        get 'home/mostsales', to: 'product#productsMostSales'      
        get 'home/lastproducts', to: 'product#lastproducts'
        resources :products, only: [:index, :show] do
          get 'preview', on: :member # products/:ID/preview
          resources :comment_products, only: [:index, :show]
          collection do 
              resources :categories, only: [:index, :show]
          end
        end
        resources :publications, only: [:index, :show]
        resources :companies, only: [:index, :show]
        get 'supplier/:id', to: 'users#supplier'

      #Administrator 

        scope '/admin' , defaults: {format: :json} do
          resources :users, only: [:edit, :show, :update] do     
            get 'home/mostsales', to: 'product#productsMostSales'      
            get 'home/lastproducts', to: 'product#lastproducts'
            resources :users, only: [:index, :show, :destroy]
            resources :products, only: [:index, :show] do
              resources :comment_products, only: [:index, :show]
              get 'preview', on: :member
              collection do 
                resources :categories, only: [:index, :show]
              end
            end
            resources :publications do 
              resources :comment_publications
            end
            resources :companies, only: [:index, :show, :destroy]
         
            get 'supplier/:id', to: 'users#suplier' #retornar los usuarios que tenga compañia
            resources :categories
          end

        end

      #Company

        scope '/company' , defaults: {format: :json} do 
          resources :users, only: [:show, :edit, :destroy] do
            get 'home/mostsales', to: 'product#productsmostsales'      
            get 'home/lastproducts', to: 'product#lastproducts'
            get 'shopsales' , to: 'product#productssales'
          
            resources :companies 
            resources :products do
              resources :comment_products, only: [:index, :show]
              get 'preview', on: :member    
              collection do          
                resources :categories, only: [:index, :show]
              end
            end
          end
        end

      #costumer
        scope '/costum', defaults: {format: :json} do
          resources :users, only: [:show, :edit, :destroy] do
            get 'home/mostsales', to: 'product#productsmostsales'      
            get 'home/lastproducts', to: 'product#lastproducts'
            get 'productsbought' , to: 'product#productsbought'
            resources :publications do
              resources :comment_publications ##
            end
            resources :products, only: [:index, :show] do
              resources :comment_products
              get 'preview', on: :member
              collection do 
                resources :categories, only: [:index, :show]
              end
            resources :categories, only: [:index]
            end
          end
        end


     end
  end
end
