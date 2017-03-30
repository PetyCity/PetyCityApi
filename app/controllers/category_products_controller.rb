class CategoryProductsController < ApplicationController
  before_action :set_category_product, only: [:show, :update, :destroy]

  # GET /category_products
  def index
     #@category_products = CategoryProduct.all

    #render json: @category_products

    #@category_products = CategoryProduct.category_by_ids(1)
    #render json: @category_products

    #@category_products = CategoryProduct.product_by_category(1)
    #render json: @category_products    


  end

  # GET /category_products/1
  def show
    render json: @category_product
  end

  # POST /category_products
  def create
    @category_product = CategoryProduct.new(category_product_params)

    if @category_product.save
      render json: @category_product, status: :created, location: @category_product
    else
      render json: @category_product.errors, status: :unprocessable_entity
    end
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
