Rails.application.routes.draw do    
devise_for :users, :defaults => { :format => 'json' }
  namespace :api do     
    namespace :v1 do 
       #resources :users
       #resources :companies
       #resources :category_products
        
         #get '/catego' => "categories#show_by_name"
       # resources :users

     
      
        get 'home/mostsales', to: 'products#productsmostsales'      
        get 'home/lastproducts', to: 'products#lastproducts'
        get 'productrandom', to: 'products#productrandom'
        get 'productbycompany/:id',to: 'products#productbycompany'
        resources :products, only: [:index, :show] do
          get 'preview', on: :member # products/:ID/preview
          get 'catego_product', to: 'category_products#catego_product', on: :member
          resources :comment_products, only: [:index, :show]
          collection do 
              resources :categories, only: [:index, :show]
          end
        end
        resources :publications, only: [:index, :show]
       
        resources :companies, only: [:index, :show]  
        #change
        resources :categories, only: [:index, :show]

      #Administrator 

        scope '/admin' , defaults: {format: :json} do
          
          resources :users, only: [ :show, :update, :destroy] do     

           
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            resources :users, only: [:index, :show, :destroy] do 
               get 'my_publications', to: 'publications#my_publications', on: :member                
               collection do 
                  get 'rol/:rol', to: 'users#users_by_rol'
               end
            
            end
            resources :products, only: [:index, :show] do
              resources :comment_products, only: [:index, :show]
              get 'preview', on: :member
              collection do 
                resources :categories, only: [:index, :show]
              end
            end
            resources :publications, only: [:index, :show, :destroy]  do 
              resources :comment_publications
            end
            resources :companies, only: [:index, :show, :destroy] do 
                 # /users/user_id/companies/company_id/products
                 resources :products, only: [:index ] , on: :member
                 # get 'product_bycompany', on: :member
            end
         
           resources :categories
          end

        end

      #Company

        scope '/company' , defaults: {format: :json} do 
          resources :users, only: [:show, :update, :destroy] do
            get 'home/mostsales', to: 'product#productsmostsales'      
            get 'home/lastproducts', to: 'product#lastproducts'
            get 'shopsales' , to: 'product#productssales'
            resources :users, only: [ :show] 
            
            resources :companies  do 
                 # /users/user_id/companies/company_id/products/id/comentproduct/id
                #/users/user_id//products/id/comentproduct/id
                
                 resources :products, only: [:index] , on: :member                    
                 
                 # get 'product_bycompany', on: :member
            end
         
            resources :publications, only: [:index, :show]
            resources :products do
              resources :images
              resources :comment_products, only: [ :show]
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
            get 'my_publications' , to: 'publications#my_publications', on: :member
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            get 'productsbought' , to: 'products#productsbought'
            #change
            resources :users, only: [ :show] 
            
            resources :publications do
              resources :comment_publications ##
            end
            resources :products, only: [:index, :show] do
              resources :comment_products
              get 'preview', on: :member
              collection do 
                resources :categories, only: [:index, :show]
              end
            resources :companies, only: [:index, :show] do 
                 # /users/user_id/companies/company_id/products
                 resources :products, only: [:index] , on: :member
                 # get 'product_bycompany', on: :member
            end 
            resources :categories, only: [:index]
            end
          end
        end


     end
  end
end
