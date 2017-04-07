Rails.application.routes.draw do



    

  namespace :api do     
    namespace :v1 do 
      resources :category_products
       devise_for :users, :defaults => { :format => 'json' }
         #get '/catego' => "categories#show_by_name"
        resources :users

        get 'catego' , to: 'categories#catego'
      
        get 'home/mostsales', to: 'products#productsmostsales'      
        get 'home/lastproducts', to: 'products#lastproducts'
        resources :products, only: [:index, :show] do
          get 'preview', on: :member # products/:ID/preview
          get 'categoproduct', to: 'category_products#categoproduct', on: :member
          resources :comment_products, only: [:index, :show]
          collection do 
              resources :categories, only: [:index, :show]
          end
        end
        resources :publications, only: [:index, :show]
        resources :companies, only: [:index, :show]
        get 'supplier/:id', to: 'users#supplier'

        #change
        resources :categories, only: [:index, :show]

      #Administrator 

        scope '/admin' , defaults: {format: :json} do
          resources :users, only: [:edit, :show, :update, :destroy] do     
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
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
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            get 'productsbought' , to: 'products#productsbought'
            #change
            
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
