class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  # GET /companies
  def index
    #todos 
    @companies = Company.only_companies
    render json: @companies
    
    #toda la informacion de compañia en especifico
    #@companies = Company.company_by_id_adminComp(1)
    #render json: @companies, :include => [:products,:category_products]  , status: :ok
    
    
    # la informacion de compañia en especifico para custummer
    #@company = Company.company_by_id(1)
    #render json: @company  , status: :ok
    

    #@companies = Company.product_sales(1)
    #render json: @companies
    
  end

  # GET /companies/1
  def show
    
      render json: @company
     
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render  status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    if @company.sales.count == 0
          
          if @company.destroy                            
              render status: :ok
          else
             render status: :unprocessable_entity 
          end
    else
      #PONERLE EL ATRIBUTO ACTIVO EN GALSE
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:nit, :name_comp, :address, :city, :phone, :permission, :user_id)
    end
end
