class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :update,:index, :show,:destroy,:users_by_rol]
  #before_filter :authenticate_user!  
  before_action :select_user_params, only: [:index,:users_by_rol,:show,:create,:search]
  #GET /api/v1/admin/users/user_id/users/
  def index
       if params.has_key?(:user_id)
           if @user_admin.rol == 'admin'   
            @users = User.only_users  
            render json: @users, :include => [] , each_serializer: UserSerializer,render_attribute:  @parametros
          else 
           render status: :forbidden
          end  
        end
  end
  
  
  
  #/api/v1/admin/users/user_id/users/rol/:rol
  def users_by_rol    
    if @user_admin.rol == 'admin'   
        if params[:rol] == 'admin' || params[:rol] == 'company' || params[:rol] == 'customer' || params[:rol] == 'company_customer'      
            @users = User.users_by_rol( params[:rol] )    
            render json: @users, :include => []  , each_serializer: UserSerializer,render_attribute:  @parametros
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
                       render json: @user, :include => [],  each_serializer: UserSerializer,render_attribute:  @parametros
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company, :products], each_serializer: UserSerializer,render_attribute:  @parametros
                elsif  @user.company_customer?
                       @user = User.user_custommer_by_id(params[:id])
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications, :cart, :sales,:company, :products], each_serializer: UserSerializer,render_attribute:  @parametros
                else 
                       @user = User.user_custommer_by_id(params[:id])                   
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications,:cart, :sales], each_serializer: UserSerializer,render_attribute:  @parametros 
                end                         
                              
            else                  
                if     @user.admin?                                 
                       render status: :forbidden
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company, :products], each_serializer: UserSerializer,render_attribute:  @parametros
                elsif  @user.company_customer?
                       @user = User.user_comp_custommer_by_id(params[:id])
                       render json: @user, :include => [:publications, :company, :products], each_serializer: UserSerializer,render_attribute:  @parametros
                else 
                       @user = User.user_custommer_by_id(params[:id])  
                       render json: @user, :include => [:publications], each_serializer: UserSerializer,render_attribute:  @parametros
                end              
            end         
    else                         
                if     @user.admin?                                 
                       @user = User.user_by_id_admin(params[:id])
                       render json: @user, :include => [], each_serializer: UserSerializer,render_attribute:  @parametros
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company,c_products: :sales], each_serializer: UserSerializer,render_attribute:  @parametros
                elsif  @user.company_customer?
                       @user = User.user_comp_custommer_by_id(params[:id])
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications, :cart, :sales,:company,c_products: :sales], each_serializer: UserSerializer,render_attribute:  @parametros
       
                else 
                       @user = User.user_custommer_by_id(params[:id])                   
                       render json: @user, :include => [:comment_Products,:comment_Publications,:publications,:cart, :sales], each_serializer: UserSerializer,render_attribute:  @parametros 
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

  # /api/v1/admin/users/:id
  # /api/v1/admin/users/:user_id/users/:id
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
                         @user.active = false
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
                         @user.active = false
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
                         @user.active = false
                       end         
                end                             
                              
            else 
                render status: :forbidden                            
            end
    else  
            if     @user.admin?                                 
                       if @user.destroy                            
                          render status: :ok
                       else
                          render status: :unprocessable_entity 
                       end   
            elsif  @user.company?
                   @user = User.user_company_by_id(params[:id])
                   if @user.co_sales.count == 0 
                       if @user.destroy                            
                          render status: :ok
                       else
                          render status: :unprocessable_entity 
                       end                            
                   else
                       @user.active = false
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
                         @user.active = false
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
                         @user.active = false
                       end         
             end            
     end  
    
  end



 def search    
    
    if params.has_key?(:q)
        @users = User.users_by_name("%#{params[:q]}%")
#       render json: @products, :include => [:product]##un helado mayor
    #          
    else
        @users = User.only_users
    
    end

    
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]
             
              if str == "created_at"||str == "document"|| str == "name_user" || str == "rol" || str == "id" || str =="email" 
               
                @users =  @users.order("#{str}": :desc)
                render json: @users, :include =>[:user], each_serializer: UserSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end
          else               
                  if str == "created_at"||str == "document"|| str == "name_user" || str == "rol" || str == "id" || str =="email"
               
                 @users =  @users.order("#{str}": :asc)
                  render json: @users, :include =>[:user], each_serializer: UserSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @users, :include =>[:user], each_serializer: UserSerializer,render_attribute:  @parametros
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


    def select_user_params 
        @parametros =  "user,"+params[:select_user].to_s  
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:document,:name_user,:block,:sendEmail,:rol,:password,:password_confirmation,:confirm_success_url,:email,:active,:image)
    end
end


