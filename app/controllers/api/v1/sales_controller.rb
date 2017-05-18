class Api::V1::SalesController < ApplicationController
  before_action :set_sale, only: [:show, :update, :destroy]

  # GET /sales
 #//api/v1/admin/users/:user_id/carts/:cart_id/sales
 
 # /api/v1/company/users/:user_id/companies/:company_id/products/:product_id/sales
 #/api/v1/admin/users/:user_id/companies/:company_id/products/:product_id/sales
 # /api/v1/company/users/:user_id/companies/:company_id/sales
 

  def index
    @user = User.find_by_id(params[:user_id])
    if @user.admin? || @user.company?
        if params.has_key?(:cart_id)
          @sale= Sale.sales_by_carts(params[:cart_id])
          render json: @sale , :include =>[]
        elsif params.has_key?(:product_id)
          @product = Product.find_by_id(params[:product_id])

          if  Integer(params[:company_id]) == @product.company_id
            @sales= Sale.sales_by_products(params[:product_id])
            render json: @sales, :include =>[]
          else
            render status: :forbidden
          end
        else 
          @sales = Sale.sales_by_companies(params[:company_id])
          render json: @sales, :include =>[]
        end
    else 
      render status: :forbidden
    end
  end



#/api/v1/admin/users/:user_id/companies/:company_id/carts/:cart_id/sales/:id(.:format)
#/api/v1/admin/users/:user_id/companies/:company_id/products/:product_id/sales/:id
#/api/v1/company/users/:user_id/carts/:cart_id/sales/:id(.:format)
#/api/v1/company/users/:user_id/products/:product_id/sales/:id(.:format)
  # GET /sales/1
  def show
    if params.has_key?(:user_id)
      @user = User.find_by_id(params[:user_id])
      @sales = Sale.sales_by_id(params[:id])
      if !@user.company? and !@user.admin?
          render status: :forbidden
      else
          render json: @sale, :include => []
      end
    end
  end

 
  # POST /sales
  #/api/v1/costum/users/:user_id/carts/:cart_id/sales(.:format)s
  def create
    @user = User.find_by_id(params[:user_id])
    if !@user.customer?
      render status: :forbidden
    else
      @transactions = Transaction.transactions_by_carts(params[:cart_id])
      @sales = Array.new
      begin  
        Sale.transaction do
          for transaction in @transactions do 
             @sale = Sale.new({:product_id => transaction.product_id, :amount => transaction.amount, :cart_id => transaction.cart_id}) 
             if @sale.save
              @sales.push(@sale)

              end
          end
          Transaction.where(cart_id: params[:cart_id]).destroy_all
        end
        render json: @sales, status: :created
      rescue => e
          puts e
          render  status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sale_params
      params.require(:sale).permit(:transaction_id, :product_id, :cart_id, :amount)
    end
end
