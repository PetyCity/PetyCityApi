class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  
  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions
  def index
    #@transactions = Transaction.all
   if params.has_key?(:cart_id)
    
   
      @transactions = Transaction.transactions_by_carts(params[:cart_id]) 
      render json: @transactions, status: :ok 
    
  end
end

  # GET /transactions/1

  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions/:id
  def show
    if params.has_key?(:user_id)
      @user = User.find_by_id(params[:user_id])
      @transaction = Transaction.transaction_by_id(params[:id])
      if !user.customer?
        render status: :forbidden

      else 

        render json: @transaction, :include =>[:product, :cart]
      end        
    end
end
  # POST /transactions
  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions
  def create
    @user = User.find_by_id(params[:user_id])
    if !@user.customer?
      render status: :forbidden

    else

      @transaction = Transaction.new({:cart_id => params[:cart_id] , :product_id => transaction_params[:product_id],:amount =>transaction_params[:amount] })
      
      if @transaction.save
        @product = Product.products_by_id(transaction_params[:product_id])
        @cart = Cart.cart_by_id(params[:cart_id])
        @total = @product[0].value*Integer(transaction_params[:amount]) + @cart.total_price
        if Cart.update(params[:cart_id], :total_price => @total)
            render json: @transaction, :include =>[] ,  status: :created
        end
      else
        render json: @transaction, :include =>[] , status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end


  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions/:id
  # DELETE /transactions/1
  def destroy
    @cart = Cart.cart_by_id(params[:cart_id])
    @product = Product.product_by_id( @transaction.product_id)
        
    @total =  @cart.total_price - @product.value*Integer(transaction_params[:amount]) 
    
    if Cart.update(params[:cart_id], :total_price => @total)
        @transaction.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:product_id, :cart_id, :amount)
    end
end
