class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:index,:show, :update, :destroy,:create,
                                     :votes_dislike,:votes_like,:user_vote,:my_vote]
  before_action :select_company_params, only: [:index,:show, :update, :destroy,:create,:search]
  after_action :actualizate_votes, only: [:user_vote ]
  
  #/api/v1/companies
  #/api/v1/admin/users/:user_id/companies
  def index     
      @companies = Company.only_companies          
      render json: @companies , :include =>[:user,:products], each_serializer: CompanySerializer,render_attribute: @parametros  
    
  end


   #/api/v1/companies/:id
  #/api/v1/admin/users/:user_id/companies/:id
 def show
    if params.has_key?(:user_id)
       if  @user.customer?     
           render json: @company , :include => [:user,:products], status: :ok  , each_serializer: CompanySerializer,render_attribute: @parametros  
       else
          render json: @company , :include => [:user,:products,:sales], status: :ok    , each_serializer: CompanySerializer,render_attribute: @parametros  
       end
    else
        render json: @company , :include => [:products], status: :ok  , each_serializer: CompanySerializer,render_attribute: @parametros  
    end
  end


    #@companies = Company.product_sales(1)
    #render json: @companies

  def search    
    
    
    if params.has_key?(:q) and  params.has_key?(:rol_id)
        @companies = Company.companies_by_name_category("%#{params[:q]}%",params[:rol_id])        
    elsif params.has_key?(:q)
        @companies = Company.companies_by_name("%#{params[:q]}%")
    elsif params.has_key?(:rol_id) 
        @companies = Company.company_by_rol(params[:rol_id])
    else
        @companies = Company.only_companies 
    
    end
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]
             
              if  str == "c_votes_like"||str == "c_votes_dislike"|| str == "nit"||str == "name_comp"|| str == "address" || str == "phone" || str == "user_id"  
               
                @companies =  @companies.reorder("#{str}": :desc)
                render json: @companies, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
              elsif  str == "sales"
                @companies =  @companies.product_sales
                render json: @companies, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
              
              else
                  render status:  :bad_request
              end
          else               
               if str == "c_votes_like"||str == "c_votes_dislike"|| str == "nit"||str == "name_comp"|| str == "address" || str == "phone" || str == "user_id"
               
                 @companies =  @companies.reorder("#{str}": :asc)
                  render json: @companies, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
               elsif  str == "sales"
                @companies =  @companies.product_sales.reorder("Count(companies.id) ASC") 
                render json: @companies, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
              
              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @companies, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
    end
  end
  #/POST /api/v1/costum/users/:user_id/companies/:id/votes
  # => para custummer 
  
  def user_vote
     if vote_params[:vote] == '0' || vote_params[:vote] == '1'   || vote_params[:vote] == '-1'       
          if  @user.customer? || @user.company_customer?#cliente y cliente compañia pueden votar 
                if vote_params[:vote] == '1'
                  
                    if !@user.voted_for? @company
                        @user.likes @company
                        @company.c_votes_like = @company.c_votes_like+1
                        render status: :ok 
                    else
                        if @user.voted_down_on? @company
                          @company.undisliked_by  @user
                          @company.c_votes_dislike = @company.c_votes_dislike-1
                          @company.c_votes_like = @company.c_votes_like+1
                          @user.likes @company
                          render status: :ok
                        else
                            render status: :forbidden #no puede votar dos veces   
                        end                        
                    end
                elsif vote_params[:vote] == '-1'
                    if @user.voted_for? @company
                        if @user.voted_down_on? @company
                           @company.undisliked_by  @user
                           @company.c_votes_dislike = @company.c_votes_dislike-1                         
                           render status: :ok
                        else                          
                          @company.c_votes_like = @company.c_votes_like-1
                          @company.unliked_by @user
                          render status: :ok       
                        end   
                    else
                         render status: :forbidden                     
                    end
                else
                    if !@user.voted_for? @company
                        @user.dislikes @company
                        @company.c_votes_dislike = @company.c_votes_dislike+1
                        render status: :ok
                    else
                        if @user.voted_up_on? @company
                          @company.unliked_by @user
                          @user.dislikes @company
                          @company.c_votes_dislike = @company.c_votes_dislike+1
                          @company.c_votes_like = @company.c_votes_like-1
                          render status: :ok                          
                        else
                            render status: :forbidden #no puede votar dos veces   
                        end
                    end
                end 
          else#usuario compalñia
                render status: :forbidden    
          end   
     else
        render status: :bad_request
     end 
  end 
  #/api/v1/costum/users/10/companies/1/my_vote
  def my_vote
     if !@user.voted_for? @company           
           render json:  false, status: :ok           
     else
           if @user.voted_uc_on? @company                          
               render json: 1,  status: :ok
           else
               render json:  0,status: :ok    
           end
     end
  end
  # POST /api/v1/company/users/:user_id/companies
  def create
      if  @user.customer? || @user.admin?#cliente y administradores no pueden crear
            render status: :forbidden     
      else#usuario compalñia
            @company = Company.new(company_params)
            if @company.save
              render  status: :created
            else
              render json: @company.errors, :include =>[], status: :unprocessable_entity, each_serializer: CompanySerializer,render_attribute: @parametros  
            end
      end   
  end

  # /api/v1/company/users/:user_id/companies/:id
  def update
    if  @user.customer? || @user.admin?#cliente y administradores no pueden crear
            render status: :forbidden     
      else#usuario compalñia
            if @company.update(company_params)
              render json: @company, :include =>[], each_serializer: CompanySerializer,render_attribute: @parametros  
            else
              render json: @company, :include =>[], status: :unprocessable_entity, each_serializer: CompanySerializer,render_attribute: @parametros  
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
    def actualizate_votes    
      @company.update_columns(c_votes_like: @company.c_votes_like,c_votes_dislike: @company.c_votes_dislike)
    end
    def select_company_params 
        @parametros =  "Company,"+params[:select_company].to_s  
    end
    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:latitude,:longitude,:nit, :name_comp, :address, :city, :phone, :permission, :user_id,:image_company,:c_rol)
    end
    def vote_params
      params.permit(:vote)
    end
    
end
