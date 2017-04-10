class Api::V1::UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!
  

  #GET /api/v1/users/user_id/users/
  def index 
    @user = User.find_by_id(params[:user_id])    
    if @user.rol == 'admin'   
      @users = User.only_users  
      render json: @users, :include => []  , status: :ok 
    else 
     render status: :forbidden
    end  
  end
  #GET /api/v1/users/user_id/users/(admin-company-custumeer)
  #GET /api/v1/users/user_id/users/rol/:rol
   def users_by_rol 
    @user = User.find_by_id(params[:user_id])
    if @user.rol == 'admin'   
      if params[:rol] == 'admin' || params[:rol] == 'company' || params[:rol] == 'customer' || params[:rol] == 'company_customer'      
        @users = User.users_by_rol( params[:rol] )    
        render json: @users, :include => []  , status: :ok 
      else
        render status: :bad_request
      end
    else 
     render status: :forbidden
    end  
  end
  

  
#GET /api/v1/admin/users/:id
#GET /api/v1/admin/users/user_id/users/:id
  def show   
    if params.has_key?(:user_id)
      #  if current_user.id == params[:user_id])
           @user = User.find_by_id(params[:user_id])
           if     @user.admin?
                @user = User.find_by_id(params[:id])  
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
                @user = User.find_by_id(params[:id])  
                if     @user.admin?                                 
                       render status: :forbidden
                elsif  @user.company?
                       @user = User.user_company_by_id(params[:id])
                       render json: @user, :include => [ :company, :products], status: :ok
                elsif  @user.company_customer?
                       @user = User.user_custommer_by_id(params[:id])
                       render json: @user, :include => [:publications, :company, :products], status: :ok
                else 
                       @user = User.user_custommer_by_id(params[:id])  
                       render json: @user, :include => [:publications], status: :ok
                end              
            end
         # else
          #  render status:  :unauthorized 
          #end
    else  
       @user = User.find_by_id(params[:id])
          # if current_user.id == params[:id])                  
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
           #end
     end  
    
  end
  

  def supplier

    @user = User.company_by_user_id(params[:id])
    render json: @user, :include => [:company]
  end 



"""
  # GET /users/new
  def new
    @user = User.new
  end
"""
  # GET /users/1/edit
  def edit
   
    render json: @user, status: :ok
  end

  # POST /users
  # POST /users.json
  """
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
"""
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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
  def destroy
    
    @user.destroy
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    
    render json: @user, status: :ok
    """
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :ok }
      else
        respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :unprocessable_entity }
      end
      """
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula,:name_user,:block,:sendEmail,:rol)
    end
end
