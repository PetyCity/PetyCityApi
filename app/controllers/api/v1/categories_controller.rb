class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.all_categories
    render json: @categories,:include => []
   
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
  

  def catego

      @categories = Category.categories_by_name("qDAJM")
      render json: @categories, :include => [:category]
  end


 
  
  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
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
