class Api::V1::CommentProductsController < ApplicationController
  before_action :set_comment_product , only: [:show, :update, :destroy,:votes_dislike,
                                              :votes_like,:user_vote,:my_vote]
  # GET /comment_products
  #/api/v1/costum/users/:user_id/products/:product_id/comment_products
  #/api/v1/products/:product_id/comment_products 
  def index
    if params.has_key?(:product_id)
      @comment_products = CommentProduct.comments_product_by_products(params[:product_id])
      render json: @comment_products, :include => [], status: :ok
    end
  end

   #/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id
   #/api/v1/products/:product_id/comment_products/:id
  def show   
   if @comment_product.length == 1
    render json: @comment_product, :include => []
   else
     render status: :forbidden
   end
  end


#/POST /api/v1/costum/users/:user_id/products/:product_id/comment_products/:id/votes
  # => para custummer 
  def user_vote
     if vote_params[:vote] == '0' || vote_params[:vote] == '1'   || vote_params[:vote] == '-1'       
          if  @user.customer? || @user.company_customer?#cliente y cliente compañia pueden votar 
                if vote_params[:vote] == '1'
                  
                    if !@user.voted_for? @comment_product
                        @user.likes @comment_product
                        render status: :ok 
                    else
                        if @user.voted_down_on? @comment_product
                          @comment_product.undisliked_by  @user
                          
                          @user.likes @comment_product
                          render status: :ok
                        else
                            render status: :forbidden #no puede votar dos veces   
                        end                        
                    end
                elsif vote_params[:vote] == '-1'
                    if @user.voted_for? @comment_product
                        if @user.voted_down_on? @comment_product
                           @comment_product.undisliked_by  @user                         
                           render status: :ok
                        else
                          
                          @comment_product.unliked_by @user
                          render status: :ok       
                        end   
                    else
                         render status: :forbidden                     
                    end
                else
                    if !@user.voted_for? @comment_product
                        @user.dislikes @comment_product
                        render status: :ok
                    else
                        if @user.voted_up_on? @comment_product
                          @comment_product.unliked_by @user
                          @user.dislikes @comment_product
                          render status: :ok                          
                        else
                            render status: :forbidden #no puede votar dos veces   
                        end
                    end
                end 
          else#usuario compalñia
                render status: :forbidden    
          end   
     else
        render status: :bad_request
     end 
  end
   
  #/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id/votes_like
  def votes_like
    @voteslike = @comment_product.get_likes
    render json:  @voteslike.count ,  status: :ok
  end
  
  #/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id/votes_dislike
  def votes_dislike    
    @votesunlike =@comment_product.get_dislikes
     render json:  @votesunlike.count ,  status: :ok
  end
  #/api/v1/costum/users/:user_id/products/:product_id/comment_products/:id/my_vote
  def my_vote
     if !@user.voted_for? @comment_product           
           render json:  false, status: :ok
           
     else
           if @user.voted_up_on? @comment_product                          
               render json: 1,  status: :ok
           else
               render json:  0,status: :forbidden #no puede votar dos veces   
           end
     end
  end
  
  # POST /comment_products  
  # /api/v1/costum/users/:user_id/products/:product_id/comment_products

  def create

    @comment_product = CommentProduct.new(comment_product_params)
    if @comment_product.save
      render json: @comment_product, :include => [], status: :created
    else
      render json: @comment_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/costum/users/:user_id/products/:product_id/comment_products/:id
  def update
    if @comment_product.update(comment_product_params)
      render json: @comment_product, :include => []
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
      if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :not_found
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                   
                @comment_product =  CommentProduct.comment_product_by_product(params[:product_id], params[:id])     
                if  @comment_product.nil?  
                       render status:   :not_found
                end
            else
              @comment_products =  CommentProduct.all                              
            end          
        else            
            if params.has_key?(:id)                  
                 #if  current_user.id != params[:id] 
                 #       render status:  :forbidden
                 # end                     
                 @comment_product =  CommentProduct.comment_product_by_product(params[:product_id], params[:id])  
                 if  @comment_product.nil?
                       render status: :not_found
                 end
             else
                  @comment_products =  CommentProduct.all
             end
         end 
    end

    # Only allow a trusted parameter "white list" through.
    def comment_product_params
      params.require(:comment_product).permit(:body_comment_product, :product_id, :user_id)
    end
    def vote_params
      params.permit(:vote)
    end
end
