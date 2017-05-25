class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy, :index, :create]

  before_action :select_transaction_params, only: [:index,:show,:create,:destroy]

  # GET /transactions
  
  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions
  def index
    #@transactions = Transaction.all
   if params.has_key?(:cart_id)
      @transactions = Transaction.transactions_by_carts(params[:cart_id]) 
      for i in @transactions do
        puts i.id
      end
      render json: @transactions, :include =>[:cart,:product], each_serializer: TransactionSerializer,render_attribute: @parametros  
    
  end
end

  # GET /transactions/1

  #/api/v1/costum/users/:user_id/carts/:cart_id/transactions/:id
 def show
    if params.has_key?(:user_id)
      @user = User.find_by_id(params[:user_id])
      @transaction = Transaction.transaction_by_id(params[:id])
      if !@user.customer?
        render status: :forbidden

      else 

        render json: @transaction, :include =>[]
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
            render json: @transaction, :include =>[] ,  each_serializer: TransactionSerializer,render_attribute: @parametros  
    
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

    puts "*********************************"
    @cart = Cart.cart_by_id(params[:cart_id])
    
    @product = Product.product_by_id( @transaction.product_id)
    #@total =  @cart.total_price - @product[0].value*Integer(transaction_params[:amount]) 
         
    @total =  @cart.total_price - @product.value*Integer(transaction_params[:amount]) 
    
    if Cart.update(params[:cart_id], :total_price => @total)
        @transaction.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_transaction
    #  @transaction = Transaction.find(params[:id])
    #end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:product_id, :cart_id, :amount)
    end

    def select_transaction_params 
        @parametros =  "transaction,"+params[:select_transaction].to_s  
    end

    # def set_transaction
    #   @transaction = Transaction.find(params[:id])
    # end


    def set_transaction
      if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :not_found
            end
           # if  current_user.id != params[:user_id].to_i 
            #      render status:  :forbidden
            #end    
            if params.has_key?(:id)
                   
                 @transaction = Transaction.find(params[:id])       
                if  @transaction.nil?  
                       render status:   :not_found
                end
            else
              @transaction = Transaction.load_transactions  

            end

        else            
            if params.has_key?(:id)
                  
                 #if  current_user.id != params[:id]) 
                 #       render status:  :forbidden
                 # end                     
                 @transaction = Transaction.find(params[:id])   
                 if  @transaction.nil?
                       render status: :not_found
                 end
             else
                  @transaction = Transaction.load_transactions 
             end
         end
    end


end
