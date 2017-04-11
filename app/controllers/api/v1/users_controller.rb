class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :update,:index, :show,:destroy,:users_by_rol]
  #before_filter :authenticate_user!
  

  #GET /api/v1/users/user_id/users/
  def index

       if params.has_key?(:user_id)
           if @user_admin.rol == 'admin'   
            @users = User.only_users  
            render json: @users, :include => []  , status: :ok 
          else 
           render status: :forbidden
          end  
        end
  end
  #GET /api/v1/users/user_id/users/(admin-company-custumeer)
  #GET /api/v1/users/user_id/users/rol/:rol
  def users_by_rol    
    if @user_admin.rol == 'admin'   
        if params[:rol] == 'admin' || params[:rol] == 'company' || params[:rol] == 'customer' || params[:rol] == 'company_customer'      
            @users = User.users_by_rol( params[:rol] )    
            render json: @users, :include => []  , status: :ok 
        else
            render status: :not_found
        end
    else 
        render status: :forbidden
    end  
  end  
#GET /api/v1/admin/users/:id
#GET /api/v1/admin/users/user_id/users/:id
  def show   
    if params.has_key?(:user_id)     
           if   @user_admin.admin?                
                if     @user.admin?                                 
                       @user = User.user_by_id_admin(params[:id])
                       render json: @user, :include => [], status: :ok
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company, :products], status: :ok
                elsif  @user.company_customer?
                       @user = User.user_custommer_by_id(params[:id])
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications, :cart, :sales,:company, :products], status: :ok
                else 
                       @user = User.user_custommer_by_id(params[:id])                   
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications,:cart, :sales], status: :ok 
                end                         
                              
            else                  
                if     @user.admin?                                 
                       render status: :forbidden
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company, :products], status: :ok
                elsif  @user.company_customer?
                       @user = User.user_comp_custommer_by_id(params[:id])
                       render json: @user, :include => [:publications, :company, :products], status: :ok
                else 
                       @user = User.user_custommer_by_id(params[:id])  
                       render json: @user, :include => [:publications], status: :ok
                end              
            end         
    else                         
                if     @user.admin?                                 
                       @user = User.user_by_id_admin(params[:id])
                       render json: @user, :include => [], status: :ok
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company,c_products: :sales], status: :ok  
                elsif  @user.company_customer?
                       @user = User.user_comp_custommer_by_id(params[:id])
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications, :cart, :sales,:company,c_products: :sales], status: :ok
       
                else 
                       @user = User.user_custommer_by_id(params[:id])                   
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications,:cart, :sales], status: :ok 
                end         
         end   
  end
  
  #TODO MUNDO PODRA USAR 
  # POST /users 
  # POST /users.json
#Creacion Pendiente, sera con devise 
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  #Creacion Pendiente, sera con devise 
  def update
    
      if @user.update(user_params)
        render json: @user, status: :ok
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user }
      else
        #format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    
    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #Cada usuario borra su perfil, y el administrador borra el de todos
  def destroy
    if params.has_key?(:user_id) #ADMINISTRADOR
           if   @user_admin.admin?                 
                if     @user.admin?                                 
                       render status: :forbidden  
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       if @user.co_sales.count == 0 
                          if @user.destroy                            
                              render status: :ok
                          else
                              render status: :unprocessable_entity 
                          end                            
                       else
                         #ESCONDERLO
                       end
                     
                elsif  @user.company_customer?
                      
                       @user = User.user_comp_custommer_by_id(params[:id])
                       if @user.co_sales.count == 0 && @user.sales.count == 0
                          if @user.destroy                            
                              render status: :ok
                          else
                              render status: :unprocessable_entity 
                          end                            
                       else
                         #ESCONDERLO
                       end
                else 
                     @user = User.user_custommer_by_id(params[:id])
                       if @user.sales.count == 0
                          if @user.destroy                            
                              render status: :ok
                          else
                              render status: :unprocessable_entity 
                          end                            
                       else
                         #ESCONDERLO
                       end         
                end                             
                              
            else 
                render status: :forbidden                            
            end
    else  
            if     @user.admin?                                 
                   render status: :forbidden  
            elsif  @user.company?
                   @user = User.user_company_by_id(params[:id])
                   if @user.co_sales.count == 0 
                       if @user.destroy                            
                          render status: :ok
                       else
                          render status: :unprocessable_entity 
                       end                            
                   else
                       #ESCONDERLO
                   end                     
             elsif  @user.company_customer?                      
                    @user = User.user_comp_custommer_by_id(params[:id])
                    if @user.co_sales.count == 0 && @user.sales.count == 0
                       if @user.destroy                            
                          render status: :ok
                       else
                          render status: :unprocessable_entity 
                       end                            
                    else
                         #ESCONDERLO
                    end
             else 
                    @user = User.user_custommer_by_id(params[:id])
                    if @user.sales.count == 0
                       if @user.destroy                            
                          render status: :ok
                       else
                          render status: :unprocessable_entity 
                       end                            
                       else
                         #ESCONDERLO
                       end         
             end            
     end  
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params.has_key?(:user_id)         
          @user_admin = User.find_by_id(params[:user_id]) 
          if  @user_admin.nil?#|| current_user.id != params[:user_id]) 
                render status:  :forbidden
          end
        #  if  current_user.id != params[:user_id]) 
         #       render status:  :forbidden
         # end    
          if params.has_key?(:id)
              @user = User.find_by_id(params[:id])          
              if  @user.nil?  
                     render status:   :not_found
              end          
          end
             #if 
           
      else
          @user = User.find_by_id(params[:id]) 
          if  @user.nil?#|| current_user.id != params[:id])
                 render status: :not_found
          end
         # if  current_user.id != params[:id])
          #       render status: :forbidden
          #end
      end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula,:name_user,:block,:sendEmail,:rol)
    end
end
