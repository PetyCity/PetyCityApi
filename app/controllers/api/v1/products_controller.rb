class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [ :update, :destroy]

  # GET /products
  def index
   
    if params.has_key?(:company_id)
      
      @products= Product.products_by_company(params[:company_id])
      render json: @products, :include => [:images]
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
  def show
    @products = Product.image_by_product(params[:id])

    render json: @products, :include => [:images, :comment_products]

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
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
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
