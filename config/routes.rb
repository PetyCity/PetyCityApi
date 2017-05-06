
Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'


  
    

  namespace :api do     
    namespace :v1 do 
       
       #resources :sales
       root to: "products#index"
       
        
         #get '/catego' => "categories#show_by_name"
       # resources :users

     
      
        get 'home/mostsales', to: 'products#productsmostsales'      
        get 'home/lastproducts', to: 'products#lastproducts'
        #get 'productrandom', to: 'products#productrandom'
       # get 'productbycompany/:id',to: 'products#productbycompany'
        resources :products, only: [:index, :show] do          
          get 'preview', on: :member # products/:ID/preview
          get 'catego_product', to: 'category_products#catego_product', on: :member
          resources :comment_products, only: [:index, :show]
          collection do 
              get 'search' => "products#search"
              resources :categories, only: [:index]
          end
        end
        resources :publications, only: [:index, :show] do
            get 'votes_like', to: 'publications#votes_like', on: :member 
            get 'votes_dislike', to: 'publications#votes_dislike', on: :member 
            collection do
                 
                 get 'search' => "publications#search"
            end
        end 
       
        resources :companies, only: [:index, :show] do 
                 # /users/user_id/companies/:id/product_bycompany                 
                  get 'votes_like', to: 'companies#votes_like', on: :member 
                  get 'votes_dislike', to: 'companies#votes_dislike', on: :member 
                  collection do
                    get 'search' => "companies#search"
                  end
                  get 'product_bycompany', to: 'products#index'
            end 
        #change

        resources :categories, only: [:index, :show] do 
                   resources :products, only: [:index]
                  collection do
                    get 'search' => "categories#search"
                  end                 
       end 


      #Administrator 

        scope '/admin' , defaults: {format: :json} do
          
          resources :users, only: [ :show, :update, :destroy] do     

           
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            resources :users, only: [:index, :show, :destroy] do 
               get 'my_publications', to: 'publications#my_publications', on: :member                
               collection do 
                  get 'rol/:rol', to: 'users#users_by_rol' 
                  get 'search' => "users#search"
            
               end
            
            end
            resources :products, only: [:index, :show] do
              resources :comment_products
              get 'preview', on: :member
              get 'catego_product', to: 'category_products#catego_product', on: :member
              collection do 

                get 'search' => "products#search"
                
                resources :categories, only: [:index]
              end
            end
            resources :publications, only: [:index, :show, :destroy]  do 
              get 'votes_like', to: 'publications#votes_like', on: :member 
              get 'votes_dislike', to: 'publications#votes_dislike', on: :member 
              get 'my_vote', to: 'publications#my_vote', on: :member 
              
               
              resources :comment_publications,only: [ :show,:create,:update,:destroy] 
              collection do
                 get 'search' => "publications#search"
              end
            end
            resources :companies, only: [:index, :show, :destroy] do                  
                  get 'votes_like', to: 'companies#votes_like', on: :member 
                  get 'votes_dislike', to: 'companies#votes_dislike', on: :member
                  get 'my_vote', to: 'companies#my_vote', on: :member  
                  collection do
                    get 'search' => "companies#search"
                  end
                 # /users/user_id/companies/:id/product_bycompany
                  get 'product_bycompany', to: 'products#index'
            end
         
            resources :categories, only: [:index, :show] do 
                   resources :products, only: [:index]
                  collection do
                    get 'search' => "categories#search"
                  end                 
             end 


          end

        end

      #Company

        scope '/company' , defaults: {format: :json} do 
          resources :users, only: [:show, :update, :destroy] do
            get 'home/mostsales', to: 'product#productsmostsales'      
            get 'home/lastproducts', to: 'product#lastproducts'
            get 'shopsales' , to: 'product#productssales'
            resources :users, only: [ :show] 
            
            resources :companies do                  
                  get 'votes_like', to: 'companies#votes_like', on: :member 
                  get 'votes_dislike', to: 'companies#votes_dislike', on: :member 
                  get 'my_vote', to: 'companies#my_vote', on: :member  
                  collection do
                    get 'search' => "companies#search"
                  end
                 # /users/user_id/companies/:id/product_bycompany
                  get 'product_bycompany', to: 'products#index'
            end
         
            resources :categories, only: [:index, :show] do 
                   resources :products, only: [:index]
                  collection do
                    get 'search' => "categories#search"
                  end                 
       end 


            resources :publications, only: [:index, :show]  do 
                get 'votes_like', to: 'publications#votes_like', on: :member 
                get 'votes_dislike', to: 'publications#votes_dislike', on: :member 
                get 'my_vote', to: 'publications#my_vote', on: :member  
                resources :comment_publications,only: [ :show,:create,:update,:destroy] 
                 collection do
                 get 'search' => "publications#search"
                 end
            end
            resources :products do             
             resources :category_products
              resources :images
              resources :comment_products
              get 'preview', on: :member
              get 'catego_product', to: 'category_products#catego_product', on: :member    
              collection do 
                get 'search' => "products#search"
                 
                resources :categories, only: [:index]
              end
            end
          end
        end
      #costumer
        scope '/costum', defaults: {format: :json} do
          resources :users, only: [:show, :update, :destroy] do
            get 'my_publications' , to: 'publications#my_publications', on: :member
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            get 'productsbought' , to: 'products#productsbought'
            #change
            resources :users, only: [ :show] 
            
            resources :publications do
              get 'votes_like', to: 'publications#votes_like', on: :member 
              get 'votes_dislike', to: 'publications#votes_dislike', on: :member 
              get 'my_vote', to: 'publications#my_vote', on: :member            
              post 'votes', to: 'publications#user_vote', on: :member
              resources :comment_publications , only: [ :show,:create,:update,:destroy] 
               collection do
                 get 'search' => "publications#search"
              end
            end
            resources :products, only: [:index, :show] do
              resources :comment_products
              get 'preview', on: :member
              get 'catego_product', to: 'category_products#catego_product', on: :member
              collection do 
                get 'search' => "products#search"
                resources :categories, only: [:index]
              end      


            end
            resources :companies, only: [:index, :show] do                  
                  get 'votes_like', to: 'companies#votes_like', on: :member 
                  get 'votes_dislike', to: 'companies#votes_dislike', on: :member
                  get 'my_vote', to: 'companies#my_vote', on: :member  
                  post 'votes', to: 'companies#user_vote', on: :member               
                  collection do
                    get 'search' => "companies#search"
                  end
                 # /users/user_id/companies/:id/product_bycompany
                  get 'product_bycompany', to: 'products#index'
            end
             resources :categories, only: [:index, :show] do 
                   resources :products, only: [:index]
                  collection do
                    get 'search' => "categories#search"
                  end                 
             end 
          end
        end


     end
  end
end
