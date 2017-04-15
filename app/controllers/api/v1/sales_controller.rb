class Api::V1::SalesController < ApplicationController
  before_action :set_sale, only: [:show, :update, :destroy]

  # GET /sales
  def index
    @sales = Sale.all
    #@sales = Sale.transactions_by_amounts_less(2)
    render json: @sales
  end

  # GET /sales/1
  def show
    @sales = Sale.sales_by_id(params[:id])
    render json: @sale, :include => [:product, :cart]
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      render json: @sale, status: :created
    else
      render json: @sale.errors, status: :unprocessable_entity
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
