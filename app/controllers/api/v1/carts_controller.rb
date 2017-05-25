class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  #/api/v1/costum/users/:user_id/carts
  def index
   
    @user = User.find_by_id(params[:user_id])
    #if  current_user.id != params[:user_id].to_i
     #         render status:  :forbidden
    #end
    if @user.customer?
      @carts = Cart.all
      render json: @carts, :include => []
    else
      render status: :forbidden
    end
  end


  # GET /carts/1
  def show
    @cart = Cart.cart_by_id(params[:id])
    render json: @cart, :include => [:products, :sales,:transactions]
  end

  # POST /carts
  #/api/v1/costum/users/:user_id/carts
  def create
    @user = User.find_by_id(params[:user_id])
    #if  current_user.id != Integer(params[:user_id]) 
     #   render status:  :forbidden
    #elsif !@user.customer?
      if !@user.customer?
      render status: :forbidden

    else
        @cart = Cart.new({ :user_id => params[:user_id], :total_price => cart_params[:total_price]})

        if @cart.save
          render json: @cart, status: :created
        else
          render json: @cart.errors, status: :unprocessable_entity
        end
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_params
      params.require(:cart).permit(:user_id, :total_price)
    end
end
