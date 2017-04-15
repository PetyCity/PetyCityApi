class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  
  # GET /categories
  #/api/v1/costum/users/:user_id/products/categories
  #GET  /api/v1/costum/users/:user_id/products/:product_id/categories
  def index
    if params.has_key?(:product_id)
        @categoryProducts = CategoryProduct.categories_by_product(params[:product_id])
        @categories = Category.categories_by_id(@categoryProducts)
        render json: @categories,:include=>[] 
    else
        @categories = Category.all_categories
        render json: @categories,:include => []

    end
   
    #@categories = Category.categories_by_ids(2)
    #render json: @categories

   

    #@categories = Category.categories_by_products
    #render json: @categories

  end


  # GET /categories/1
  def show    
   @categories = Category.categories_by_id( params[:id] )
    render json: @categories, :include =>[]
  end
  


  # POST /categories

  #/api/v1/admin/users/:user_id/categories(.:format)

  def create
   @user = User.find_by_id(params[:user_id])

    if !@user.admin?

      render status: :forbidden
    else 
        @category = Category.new(category_params)

        if @category.save
          render json: @category, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
     end
  end
  # PATCH/PUT /categories/1
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.admin?
      render status: :forbidden      
    else

        if @category.update(category_params)
            render json: @category
        else
           render json: @category.errors, status: :unprocessable_entity
        end
    end
  end
  # DELETE /categories/1
  def destroy
    @user = User.find_by_id(params[:user_id])
    if !@user.admin?
      render status: :forbidden
    else
      @category.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name_category, :details)
    end
end
