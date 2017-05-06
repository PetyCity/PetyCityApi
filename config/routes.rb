
Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  namespace :api do     
    namespace :v1 do 
       root to: "products#index"
       get 'home/mostsales', to: 'products#productsmostsales'      
       get 'home/lastproducts', to: 'products#lastproducts'
       resources :products, only: [:index, :show] do
          collection do 
            get 'search' => "products#search"
            resources :categories, only: [:index]
          end
          member do
            get 'preview'
            get 'catego_product', to: 'category_products#catego_product'
            get 'stars_prom', to: 'products#stars_prom' 
            get 'num_votes', to: 'products#num_votes'           
          end          
          resources :comment_products, only: [:index, :show] do
            member do
              get 'votes_like', to: 'comment_products#votes_like' 
              get 'votes_dislike', to: 'comment_products#votes_dislike'
            end              
          end          
        end
        resources :publications, only: [:index, :show] do
          member do
            get 'votes_like', to: 'publications#votes_like'
            get 'votes_dislike', to: 'publications#votes_dislike'             
          end
          collection do                 
            get 'search' => "publications#search"
          end
        end       
        resources :companies, only: [:index, :show] do                
          get 'product_bycompany', to: 'products#index'
          member do
            get 'votes_like', to: 'companies#votes_like' 
            get 'votes_dislike', to: 'companies#votes_dislike' 
          end
          collection do
            get 'search' => "companies#search"
          end          
        end
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
              collection do
                get 'my_publications', to: 'publications#my_publications'
              end                
              collection do 
                get 'rol/:rol', to: 'users#users_by_rol' 
                get 'search' => "users#search"
              end            
            end
            resources :products, only: [:index, :show] do
              member do
                get 'preview'
                get 'catego_product', to: 'category_products#catego_product'
                get 'stars_prom', to: 'products#stars_prom' 
                get 'num_votes', to: 'products#num_votes'
              end
              collection do
                get 'search' => "products#search"                
                resources :categories, only: [:index]
              end
              resources :comment_products do
                member do
                  get 'votes_like', to: 'comment_products#votes_like'
                  get 'votes_dislike', to: 'comment_products#votes_dislike' 
                  get 'my_vote', to: 'comment_products#my_vote'            
                end
              end              
            end
            resources :publications, only: [:index, :show, :destroy]  do 
              member do
                get 'votes_like', to: 'publications#votes_like'
                get 'votes_dislike', to: 'publications#votes_dislike'
                get 'my_vote', to: 'publications#my_vote'
              end
              resources :comment_publications,only: [ :show,:create,:update,:destroy] do
                member do
                  get 'votes_like', to: 'comment_publications#votes_like'
                  get 'votes_dislike', to: 'comment_publications#votes_dislike' 
                  get 'my_vote', to: 'comment_publications#my_vote'            
                end
              end 
              collection do
                 get 'search' => "publications#search"
              end
            end
            resources :companies, only: [:index, :show, :destroy] do              
              member do
                get 'votes_like', to: 'companies#votes_like' 
                get 'votes_dislike', to: 'companies#votes_dislike'
                get 'my_vote', to: 'companies#my_vote'               
              end 
              get 'product_bycompany', to: 'products#index'
              collection do
                get 'search' => "companies#search"
              end              
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
              get 'product_bycompany', to: 'products#index'
              member do
                 get 'votes_like', to: 'companies#votes_like' 
                 get 'votes_dislike', to: 'companies#votes_dislike' 
                 get 'my_vote', to: 'companies#my_vote'
              end    
              collection do
                get 'search' => "companies#search"
              end              
            end         
            resources :categories, only: [:index, :show] do               
              collection do
                get 'search' => "categories#search"
              end          
              resources :products, only: [:index] 
            end 
            resources :publications, only: [:index, :show]  do 
                member do
                  get 'votes_like', to: 'publications#votes_like' 
                  get 'votes_dislike', to: 'publications#votes_dislike' 
                  get 'my_vote', to: 'publications#my_vote'  
                end                
                collection do
                  get 'search' => "publications#search"
                end
                resources :comment_publications,only: [ :show,:create,:update,:destroy] do
                  member do
                    get 'votes_like', to: 'comment_publications#votes_like'
                    get 'votes_dislike', to: 'comment_publications#votes_dislike' 
                    get 'my_vote', to: 'comment_publications#my_vote'            
                  end
                end
            end
            resources :products do             
              resources :category_products
              resources :images
              resources :comment_products do
                member do
                  get 'votes_like', to: 'comment_products#votes_like'
                  get 'votes_dislike', to: 'comment_products#votes_dislike' 
                  get 'my_vote', to: 'comment_products#my_vote'            
                end
              end
              member do
                get 'preview'
                get 'catego_product', to: 'category_products#catego_product' 
                get 'stars_prom', to: 'products#stars_prom' 
                get 'num_votes', to: 'products#num_votes'                
              end
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
            get 'home/mostsales', to: 'products#productsmostsales'      
            get 'home/lastproducts', to: 'products#lastproducts'
            get 'productsbought' , to: 'products#productsbought'            
            get 'my_publications' , to: 'publications#my_publications', on: :member
            resources :users, only: [ :show]             
            resources :publications do
              member do
                get 'votes_like', to: 'publications#votes_like' 
                get 'votes_dislike', to: 'publications#votes_dislike' 
                get 'my_vote', to: 'publications#my_vote'            
                post 'votes', to: 'publications#user_vote'
              end              
              resources :comment_publications , only: [ :show,:create,:update,:destroy] do 
                member do
                  get 'votes_like', to: 'comment_publications#votes_like'
                  get 'votes_dislike', to: 'comment_publications#votes_dislike' 
                  get 'my_vote', to: 'comment_publications#my_vote'
                  post 'votes', to: 'comment_publications#user_vote'          
                end
              end
              collection do
                get 'search' => "publications#search"
              end
            end
            resources :products, only: [:index, :show] do
              resources :comment_products do
                member do
                  get 'votes_like', to: 'comment_products#votes_like'
                  get 'votes_dislike', to: 'comment_products#votes_dislike' 
                  get 'my_vote', to: 'comment_products#my_vote'
                  post 'votes', to: 'comment_products#user_vote'            
                end
              end
              member do
                get 'stars_prom', to: 'products#stars_prom' 
                get 'num_votes', to: 'products#num_votes'
                get 'my_vote', to: 'products#my_vote'
                post 'votes', to: 'products#user_vote' 
                get 'preview'
                get 'catego_product', to: 'category_products#catego_product'              
              end
              collection do 
                get 'search' => "products#search"
                resources :categories, only: [:index]
              end
            end
            resources :companies, only: [:index, :show] do
              get 'product_bycompany', to: 'products#index'
              member do
                get 'votes_like', to: 'companies#votes_like' 
                get 'votes_dislike', to: 'companies#votes_dislike'
                get 'my_vote', to: 'companies#my_vote'  
                post 'votes', to: 'companies#user_vote'
              end
              collection do
                get 'search' => "companies#search"
              end              
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
