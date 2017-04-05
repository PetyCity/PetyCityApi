class Api::V1::CommentProductsController < ApplicationController
  before_action :set_comment_product, only: [:show, :update, :destroy]

  # GET /comment_products
  def index
    @comment_products = CommentProduct.all
    render json: @comment_products

    # @coment_products = ComentProduct.coment_by_ids(6)
    #render json: @coment_products
    
 
    #@coment_products = ComentProduct.coment_product_by_user(2)
    #render json: @coment_products

    #@coment_products = ComentProduct.all_coments
    #render json: @coment_products

  end

  # GET /comment_products/1
  def show
    render json: @comment_product
  end

  # POST /comment_products
  def create
    @comment_product = CommentProduct.new(comment_product_params)

    if @comment_product.save
      render json: @comment_product, status: :created, location: @comment_product
    else
      render json: @comment_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comment_products/1
  def update
    if @comment_product.update(comment_product_params)
      render json: @comment_product
    else
      render json: @comment_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comment_products/1
  def destroy
    @comment_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_product
      @comment_product = CommentProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_product_params
      params.require(:comment_product).permit(:body_comment_product, :product_id, :user_id)
    end
end
