class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [ :update, :destroy]

  # GET /products
  #/api/v1/admin/users/:user_id/companies/:company_id/product_bycompany
  #/api/v1/costum/users/:user_id/companies/:company_id/product_bycompany
  #/api/v1/company/users/:user_id/companies/:company_id/product_bycompany(.:format)
  #/api/v1/companies/:company_id/product_bycompany(.:format)
  #/products
  
  def index
   
    if params.has_key?(:company_id)
          @products= Product.products_by_company(params[:company_id])
          if params.has_key?(:user_id)    
                @company = Company.find_by_id(params[:company_id])  

                if  @company.user_id == Integer(params[:user_id]  )          
                      render json: @products, :include => [:images, :comment_products,:categories,:company, :sales, :users]
                else
                     render json: @products, :include => [:images, :comment_products,:categories,:company, :users]
                end
          else
                render json: @products, :include => [:images, :comment_products,:categories,:company]
          

          end
    else
      @products= Product.rand
      render json: @products, :include => [:images]
    end
    #@products = Product.all_products
    #render json: @products
    
    #@products = Product.products_by_id(5)
    #render json: @products
    
   # @products = Product.products_by_company(3)
    #render json: @products
   
   
        #render json: @products, root: "products"     
    #@products = Product.products_by_id(1)
    #render json: @products    
    #@products = Product.products_by_company(1)
    #render json: @products   
    #@products = Product.published
    #render json: @products  
    #@products = Product.products_transactions(2)
    #render json: @products
        #.............................
    #@products = Product.products_sales(2)
   # render json: @products   
   # @products = Product.comment_product_by_id(2)
    #render json: @products , :include => [:comment_products,:users]  
    #@products = Product.ultimos
    #render json: @products
    #@products = Product.products_by_category(3)
    #render json: @products
    #@products = Product.cheaper_than(10003)
   # render json: @products
   
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
         
          render json: @products, :include => [:images, :comment_products,:categories,:company, :sales, :users]

        #else
         # render status: :forbidden  
       # end
      else
        
        render json: @products, :include => [:images, :comment_products,:categories,:company, :users]

      end
    else
      @products = Product.product_by_id_total(params[:id])
      render json: @products, :include => [:images, :comment_products,:categories,:company]
    end

  end



  def lastproducts
    @products = Product.ultimos
    render json: @products,:include => []
  end 


  
  def productsmostsales

   @products = Product.products_most_sales
   
   @products = Product.products_by_id(@products)
   
    render json: @products, :include => []

  end

  def productrandom
   @products = Product.rand
  render json: @products, :include => [:images]

  end

  ##/users/user_id/companies/company_id/product_bycompany
  def product_bycompany
    @products = Product.products_by_company(params[:id])
    render json: @products, :include => []
  
  end 

  # POST /products


#/api/v1/company/users/:user_id/companies/products


  def create
    @user = User.find_by_id(params[:user_id])

    if !@user.company? && !@user.company_customer?
      render status: :forbidden

    else

      @product = Product.new(product_params)

      if @product.save
        render json: @product, status: :created
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /products/1
  #/api/v1/company/users/:user_id/companies/:id(.:format)
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
        #esconderlo
      end 
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name_product, :description, :status, :value, :amount, :company_id)
    end


end
