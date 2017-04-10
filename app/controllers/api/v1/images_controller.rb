class Api::V1::ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /images
  def index
    @images = Image.all
    #@images = Image.images_by_name("casa22")

    render json: @images
  end

  # GET /images/1
  def show
    @image = Image.image_by_id(params[:id])
    render json: @image, :include => [:product]
  end


  # POST /images
  def create
    @image = Image.new(image_params)
     @image.save
    #if @image.save
     # render json: @image, status: :created, location: @image
    #else
    #  render json: @image.errors, status: :unprocessable_entity
    #end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:name_image, :product_id)
    end
end
