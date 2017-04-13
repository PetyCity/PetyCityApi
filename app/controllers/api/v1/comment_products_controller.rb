class Api::V1::CommentProductsController < ApplicationController
  before_action :set_comment_product, only: [:show, :update, :destroy]

  # GET /comment_products
  #/api/v1/costum/users/:user_id/products/:product_id/comment_products
  #/api/v1/products/:product_id/comment_products 
  def index
    if params.has_key?(:product_id)
      @comment_products = CommentProduct.comments_product_by_products(params[:product_id])
      render json: @comment_products, status: :ok
    end
  end

   #/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id
   #/api/v1/products/:product_id/comment_products/:id
  def show    
   @comment_product = CommentProduct.comment_product_by_product(params[:product_id], params[:id])
   if @comment_product.length == 1
    render json: @comment_product
   else
     render status: :forbidden
   end
  end
  
  
  # /api/v1/costum/users/:user_id/products/:product_id/comment_products
  def create
    @comment_product = CommentProduct.new(comment_product_params)
    if @comment_product.save
      render json: @comment_product, status: :created, location: @comment_product
    else
      render json: @comment_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/costum/users/:user_id/products/:product_id/comment_products/:id
  def update
    if @comment_product.update(comment_product_params)
      render json: @comment_product
    else
      render json: @comment_product.errors, status: :unprocessable_entity
    end
  end
#/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id(.:format)
  # DELETE /comment_products/1
  def destroy
    
    if @comment_product.user_id == Integer(params[:user_id])  #El usuario de la publicacion es el mismo usuario logueado
              if @comment_product.destroy                            
                 render status: :ok
              else
                  render status: :unprocessable_entity 
              end              
    else
            render status: :forbidden #no la pede borrar
    end 


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_product
      @comment_product = CommentProduct.find(params[:id])
      #  if  current_user.id != Integer( params[:user_id]) ) 
           #       render status:  :forbidden
           # end  
    end

    # Only allow a trusted parameter "white list" through.
    def comment_product_params
      params.require(:comment_product).permit(:body_comment_product, :product_id, :user_id)
    end
end
