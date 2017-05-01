class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [ :update, :destroy]
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
      render json: @products, :include => [:images] , each_serializer: ProductSerializer,render_attribute:  @parametros

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

   @products = Product.products_most_sales
   
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

 def search    
    
    if params.has_key?(:q)
        @products = Product.products_by_name("%#{params[:q]}%")
#       render json: @products, :include => [:product]
    #          
    else
        @products = Product.products_images
    
    end

    
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]
              puts "sebastian herrera"
              puts str
              if str == "created_at"||str == "name_product"|| str == "description" ||str == "status" ||str == "value" ||str == "amount" || str == "company_id"|| str == "id"
                @products =  @products.order("#{str}": :desc)
                render json: @products, :include =>[:product,:images] , each_serializer: ProductSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end
          else               
              if str == "created_at"||str == "name_product"|| str == "description" ||str == "status" ||str == "value" ||str == "amount" || str == "company_id"|| str == "id"
                  @products =  @products.order("#{str}": :asc)
                  render json: @products, :include =>[:product,:images], each_serializer: ProductSerializer,render_attribute:  @parametros

              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @products, :include =>[:product,:images], each_serializer: ProductSerializer,render_attribute:  @parametros
    end
  end

  # POST /products


#/api/v1/company/users/:user_id/products


  def create
    @user = User.find_by_id(params[:user_id])

    if !@user.company? && !@user.company_customer?
      render status: :forbidden

    else

      @product = Product.new(product_params)

      if @product.save
        render json: @product, status: :created
      else
        render json: @product, status: :unprocessable_entity
      end
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
      @product = Product.find(params[:id])
    end
    def select_product_params 
        @parametros =  "product,"+params[:select_product].to_s  
    end
    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name_product, :description, :status, :value, :amount, :company_id)
    end


end
