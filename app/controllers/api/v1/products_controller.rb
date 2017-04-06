class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
   
    @products = Product.all_products
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
    
    
    render json: @products, :include => []
   
  end

  # GET /products/1
  def show
    render json: @product
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
