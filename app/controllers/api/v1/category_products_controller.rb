class Api::V1::CategoryProductsController < ApplicationController
  before_action :set_category_product, only: [:show, :update, :destroy]

  # GET /category_products
  def index
  
  @category_products=CategoryProduct.all
  render json: @category_products 

   # @category_products = CategoryProduct.products_by_category(2)
    #render json: @category_products, :include => [:product]   

    #@category_products = CategoryProduct.categories_by_product(2)
    #render json: @category_products, :include => [:category]   


  end

  # GET /category_products/1
  def show
    render json: @category_product
  end

  def catego_product
       # if params.has_key?(:user_id)
      @category_products = CategoryProduct.categories_by_product( params[:id] )
      @category_products = CategoryProduct.products_by_category( @category_products )
      
      render json: @category_products, :include => [:category,product: :images]     
      
  end

  # POST /category_products
  def create
    @category_product = CategoryProduct.new(category_product_params)
    @category_product.save
  #  if @category_product.save
     # render json: @category_product, status: :created, location: @category_product
   # else
      #render json: @category_product.errors, status: :unprocessable_entity
    #end
  end

  # PATCH/PUT /category_products/1
  def update
    if @category_product.update(category_product_params)
      render json: @category_product
    else
      render json: @category_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /category_products/1
  def destroy
    @category_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_product
      @category_product = CategoryProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_product_params
      params.require(:category_product).permit(:product_id, :category_id)
    end
end
