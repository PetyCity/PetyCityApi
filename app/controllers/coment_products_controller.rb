class ComentProductsController < ApplicationController
  before_action :set_coment_product, only: [:show, :update, :destroy]

  # GET /coment_products
  def index
    @coment_products = ComentProduct.all

    render json: @coment_products
  end

  # GET /coment_products/1
  def show
    render json: @coment_product
  end

  # POST /coment_products
  def create
    @coment_product = ComentProduct.new(coment_product_params)

    if @coment_product.save
      render json: @coment_product, status: :created, location: @coment_product
    else
      render json: @coment_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coment_products/1
  def update
    if @coment_product.update(coment_product_params)
      render json: @coment_product
    else
      render json: @coment_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coment_products/1
  def destroy
    @coment_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coment_product
      @coment_product = ComentProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coment_product_params
      params.require(:coment_product).permit(:body, :product_id, :user_id)
    end
end
