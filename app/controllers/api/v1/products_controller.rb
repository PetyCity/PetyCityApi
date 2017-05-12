class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:user_vote, :stars_prom, :num_votes,
      :my_vote, :update, :destroy]
  after_action :stars_prom, only: [:user_vote ]
  before_action :select_product_params, only: [:index,:show, :lastproducts, :productsmostsales,
    :productrandom,:product_bycompany,:create,:search]

  # GET /products
  #/api/v1/admin/users/:user_id/companies/:company_id/product_bycompany
  #/api/v1/costum/users/:user_id/companies/:company_id/product_bycompany
  #/api/v1/company/users/:user_id/companies/:company_id/product_bycompany(.:format)
  #/api/v1/companies/:company_id/product_bycompany(.:format)
  #/api/v1/products
  
  def index   
    if params.has_key?(:company_id)
          @products= Product.products_by_company(params[:company_id])
          if params.has_key?(:user_id)    
                @company = Company.find_by_id(params[:company_id])  

                if  @company.user_id == Integer(params[:user_id]  )          
                      render json: @products, :include => [:images, :comment_products,:categories,:company, :sales, :users] , each_serializer: ProductSerializer,render_attribute:  @parametros

                else
                     render json: @products, :include => [:images, :comment_products,:categories,:company, :users] , each_serializer: ProductSerializer,render_attribute:  @parametros

                end
          else
                render json: @products, :include => [:images, :comment_products,:categories,:company],  each_serializer: ProductSerializer,render_attribute:  @parametros          

          end
    elsif params.has_key?(:category_id)
        @products= Product.products_by_categories(params[:category_id])
        render json: @products, :include => [:images]
    else
      @products= Product.rand
      if params.has_key?(:user_id)    
                @user = User.find_by_id(params[:user_id]) 
                if  @user.customer?
                   @products_like = ((@user.votes.up).where(votable_type:  "Product" )).pluck(:votable_id)
                   @categories = CategoryProduct.categories_by_product(@products_like)
                   @products_category= Product.products_by_categories(@categories)                   
                   
                   @companies_like = ((@user.votes.up).where(votable_type:  "Company" )).pluck(:votable_id)
                   @products_company = Product.products_distinc_by_company(@companies_like,@products_category.pluck(:id)).limit(15)
                   
                   @products_relashion = (@products_category + @products_company)
                   
                   @products = @products_relashion + Product.rand_custummer(@products_relashion.pluck(:id))   
                   render json: @products , :include => [:images] , each_serializer: ProductSerializer,render_attribute:  @parametros                   
                    
                else                  
                  render json: @products, :include => [:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
       
                end
       else
         
         render json: @products, :include => [:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
       end      
    end
  end
  # GET /products/1
  # GET /products/:id
  # GET /api/v1/admin/users/user_id/products/:id
  # GET /api/v1/company/users/user_id/products/:id
  # GET /api/v1/customer/users/user_id/products/:id
  def show
    if params.has_key?(:user_id)
      #  if current_user.id == params[:user_id])
      @user = User.find_by_id(params[:user_id])
      @products = Product.product_by_id_total(params[:id])
      if !@user.customer?  
       # if @products.user_id == @user.id
         
          render json: @products, :include => [:images, :comment_products,:categories,:company, :sales, :users] , each_serializer: ProductSerializer,render_attribute:  @parametros

        #else
         # render status: :forbidden  
       # end
      else
        
        render json: @products, :include => [:images, :comment_products,:categories,:company, :users] , each_serializer: ProductSerializer,render_attribute:  @parametros

      end
    else
      @products = Product.product_by_id_total(params[:id])
      render json: @products, :include => [:images, :comment_products,:categories,:company] , each_serializer: ProductSerializer,render_attribute:  @parametros
    end

  end



  def lastproducts
    @products = Product.ultimos
    render json: @products,:include => [] , each_serializer: ProductSerializer,render_attribute:  @parametros
  end   
  
  def productsmostsales
   @products = Product.products_most_sales.limit(4).pluck("products.id") 
   @products = Product.products_by_id(@products)   
    render json: @products, :include => [] , each_serializer: ProductSerializer,render_attribute:  @parametros
  end

  def productrandom
   @products = Product.rand
   render json: @products, :include => [:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
  end

  ##/users/user_id/companies/company_id/product_bycompany
  def product_bycompany
    @products = Product.products_by_company(params[:id])
    render json: @products, :include => [] , each_serializer: ProductSerializer,render_attribute:  @parametros
  
  end 
#http://localhost:3000/api/v1/products/search?q=W&sort=name_prodt
#http://localhost:3000/api/v1/products/search?category_id=2&q=g
 def search    
    
     if params.has_key?(:q) and  params.has_key?(:category_id)
        @products = Product.products_by_category_name(params[:category_id],"%#{params[:q]}%")
    
    elsif params.has_key?(:category_id)
        @products= Product.products_by_categories(params[:category_id])
    elsif params.has_key?(:q)
        @products = Product.products_by_name("%#{params[:q]}%")
    else
        @products = Product.products_images
    
    end

    
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]              
              if str == "votes_number"||str == "votes_average"||str == "created_at"||str == "name_product"|| str == "description" ||str == "status" ||str == "value" ||str == "amount" || str == "company_id"|| str == "id"
                @products =  @products.reorder("#{str}": :desc)
                render json: @products, :include =>[:product,:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
              elsif str == "sales"
                @products = Product.products_most_sales_unique( @products.pluck(:id))
                render json: @products, :include =>[:product,:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
              elsif str == "comments"
                @products = Product.products_most_comment(@products.pluck(:id) ) #@products.pluck(:id)).reorder("SUM(sales.amount) ASC") 
                render json: @products, :include =>[:product,:images,:comment_products] , each_serializer: ProductSerializer,render_attribute:  @parametros
              
              else
                  render status:  :bad_request
              end
          else               
              if str == "votes_number"||str == "votes_average"||str == "created_at"||str == "name_product"|| str == "description" ||str == "status" ||str == "value" ||str == "amount" || str == "company_id"|| str == "id"
                  @products =  @products.reorder("#{str}":  :asc)
                  render json: @products, :include =>[:product,:images], each_serializer: ProductSerializer,render_attribute:  @parametros
              elsif str == "sales"
                @products = Product.products_most_sales_unique( @products.pluck(:id)).reorder("SUM(sales.amount) ASC") 
                render json: @products, :include =>[:product,:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
              elsif str == "comments"
                @products = Product.products_most_comment(@products.pluck(:id) ).reorder("Count(products.id) ASC")
                render json: @products, :include =>[:product,:images,:comment_products] , each_serializer: ProductSerializer,render_attribute:  @parametros
              
              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @products, :include =>[:product,:images], each_serializer: ProductSerializer,render_attribute:  @parametros
    end
  end

#/POST  /api/v1/costum/users/:user_id/products/:id/votes
  # => para custummer 
  def user_vote        
     if  vote_params[:vote] == '1'  || vote_params[:vote] == '2'|| vote_params[:vote] == '3'|| vote_params[:vote] == '4'|| vote_params[:vote] == '5' || vote_params[:vote] == '-1'       
          if  @user.customer? || @user.company_customer?#cliente y cliente compañia pueden votar 
                if vote_params[:vote] == '1'                  
                    if !@user.voted_for? @product
                        @product.liked_by @user, :vote_weight => 1
                        @product.votes_number = @product.votes_number+1
                        render status: :ok 
                    else
                        @product.unliked_by  @user                         
                        @product.liked_by @user, :vote_weight => 1
                        render status: :ok      
                    end
                elsif vote_params[:vote] == '2'                  
                    if !@user.voted_for? @product
                        @product.liked_by @user, :vote_weight => 2
                        @product.votes_number = @product.votes_number+1
                        render status: :ok 
                    else
                        @product.unliked_by  @user                         
                        @product.liked_by @user, :vote_weight => 2
                        render status: :ok      
                    end
                elsif vote_params[:vote] == '3'                  
                    if !@user.voted_for? @product
                        @product.liked_by @user, :vote_weight => 3
                        @product.votes_number = @product.votes_number+1
                        render status: :ok 
                    else
                        @product.unliked_by  @user                         
                        @product.liked_by @user, :vote_weight => 3
                        render status: :ok      
                    end
                elsif vote_params[:vote] == '4'                  
                    if !@user.voted_for? @product
                        @product.liked_by @user, :vote_weight => 4
                        @product.votes_number = @product.votes_number+1
                        render status: :ok 
                    else
                        @product.unliked_by  @user                         
                        @product.liked_by @user, :vote_weight => 4
                        render status: :ok      
                    end
                elsif vote_params[:vote] == '5'                  
                    if !@user.voted_for? @product
                        @product.liked_by @user, :vote_weight => 5
                        @product.votes_number = @product.votes_number+1
                        render status: :ok 
                    else
                        @product.unliked_by  @user                         
                        @product.liked_by @user, :vote_weight => 5
                        render status: :ok      
                    end
                elsif vote_params[:vote] == '-1'
                    if @user.voted_for? @product
                        @product.unliked_by @user
                        @product.votes_number = @product.votes_number-1
                        render status: :ok                           
                    else
                         render status: :forbidden                     
                    end                
                end 
          else
                render status: :forbidden    
          end   
     else
        render status: :bad_request
     end    
  end
   
 
  # /api/v1/costum/users/:user_id/products/:id/my_vote
  def my_vote
     if !@user.voted_for? @product           
           render json:  false, status: :ok           
     else           
         render json:  (@product.get_likes.find_by voter_id:  @user.id).vote_weight ,status: :ok             
     end
  end
  
 # POST /products
#/api/v1/company/users/:user_id/products
  def create
    @user = User.company_by_user_id(params[:user_id])
    if !@user.company? && !@user.company_customer? 
      render status: :forbidden
    elsif  @user.company.permission == true
      @product = Product.new(product_params)
      if @product.save
        render json: @product, status: :created, each_serializer: ProductSerializer,render_attribute:  @parametros 
      else
        render json: @product, status: :unprocessable_entity, each_serializer: ProductSerializer,render_attribute:  @parametros 
      end
    else
      render status: :forbidden
    end
  end

  # PATCH/PUT /products/1
#/api/v1/company/users/:user_id/products/:id
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.company? && !@user.company_customer?
      render status: :forbidden
    else 
      if @product.update(product_params)
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end


  #/api/v1/company/users/:user_id/companies/:id(.:format)
  # DELETE /products/1
  def destroy
    @user = User.find_by_id(params[:user_id])
    @product = Product.products_sales(params[:id])
    if !@user.company?
      render status: :forbidden
    else
       @product = Product.products_sales(params[:id])
      if @product.sales.count == 0
         @product.destroy
      else 
        @product.active = false
        #esconderlo
      end 
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product   
      if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :not_found
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                   
                @product =  Product.product_by_id_total(params[:id])     
                if  @product.nil?  
                      render status:   :not_found
                end
            else
              @products =  Product.all                              
            end          
        else            
            if params.has_key?(:id)                  
                 #if  current_user.id != params[:id] 
                 #       render status:  :forbidden
                 # end                     
                 @product =  Product.product_by_id_total(params[:id]) 
                 if  @product.nil?
                       render status: :not_found
                 end
             else
                  @products =  Product.all
             end
         end 
    end
    def stars_prom
       @voteslike = @product.get_likes 
       @prom = Float(@voteslike.sum(:vote_weight)) / Float(@voteslike.count)      
       @product.votes_average = @prom 
       @product.update_columns(votes_average: @product.votes_average,votes_number: @product.votes_number)      
   end 

    def select_product_params 
        @parametros =  "product,"+params[:select_product].to_s  
    end
    def product_params
      params.require(:product).permit(:name_product, :description, :status, :value, :amount, :company_id)
    end
    def vote_params
      params.permit(:vote)
    end

end
