class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:index,:show, :update, :destroy,:create]

  #/api/v1/companies
  #/api/v1/admin/users/:user_id/companies
  def index     
      @companies = Company.only_companies    
      render json: @companies , :include =>[:user,:products]   
  end

   #/api/v1/companies/:id
  #/api/v1/admin/users/:user_id/companies/:id
 def show
    if params.has_key?(:user_id)
       if  @user.customer?     
           render json: @company , :include => [:user,:products], status: :ok 
       else
          render json: @company , :include => [:user,:products,:sales], status: :ok    
       end
    else
        render json: @company , :include => [:products], status: :ok 
    end
  end


    #@companies = Company.product_sales(1)
    #render json: @companies
    
    
     
  # POST /api/v1/company/users/:user_id/companies
  def create
      if  @user.customer? || @user.admin?#cliente y administradores no pueden crear
            render status: :forbidden     
      else#usuario compalñia
            @company = Company.new(company_params)
            if @company.save
              render  status: :created
            else
              render json: @company, status: :unprocessable_entity
            end
      end   
  end

  # /api/v1/company/users/:user_id/companies/:id
  def update
    if  @user.customer? || @user.admin?#cliente y administradores no pueden crear
            render status: :forbidden     
      else#usuario compalñia
            if @company.update(company_params)
              render json: @company
            else
              render json: @company, status: :unprocessable_entity
            end
      end   
      
      
    
  end

  # DELETE /companies/1
  def destroy
    if  @user.customer? #El cliente no puede borrar nada
          render status: :forbidden  
    elsif  @user.admin?#Administrador puede borar todas
          if @company.sales.count == 0            
                if @company.destroy                            
                    render status: :ok
                else
                   render status: :unprocessable_entity 
                end
          else
            @company.active = false
                  #PONERLE EL ATRIBUTO ACTIVO EN FALSE
          end
    else#que tenga compañia
          if @company.user.id ==  params[:user_id]  #El usuario de la compañia es el mismo usuario logueado
              if @company.sales.count == 0            
                    if @company.destroy                            
                        render status: :ok
                    else
                       render status: :unprocessable_entity 
                    end
              else
                @company.active = false
                      #PONERLE EL ATRIBUTO ACTIVO EN FALSE
              end
          else
            render status: :forbidden #no la pede borrar
          end 
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   def set_company        
        if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :forbidden
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                @company = Company.company_by_id_adminComp(params[:id])          
                if  @company.nil?  
                       render status:   :not_found
                end          
            end          
        else
            if params.has_key?(:id)
                @company = Company.company_by_id(params[:id])    
                if  @company.nil?
                       render status: :not_found
                end
             end
         end
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:nit, :name_comp, :address, :city, :phone, :permission, :user_id,:image_company)
    end
end
