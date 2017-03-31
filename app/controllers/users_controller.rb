class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    #TODOS LOS USUARIOS
    #@user = User.only_users
    #render json: @user, status: :ok
    
    
    #Usuario by id, toda la informacion completa para admin
    #@user = User.user_by_id_admin(1)
    #render json: @user, :include => [:company,:products]  , status: :ok
    #render json: @user, :include => [:company => {:only => :name_comp}}  , status: :ok
    
    #Usuario by id custumer and company    
    #@user = User.user_by_id(2)
    #render json: @user, status: :ok
    
    #Compañias  ---  ver usuario_compañias  
    #@user = User.company_by_user()
    #render json: @user, status: :ok
    ########################################
    #Compañia  ---  ver usuario_compañia  
    #@user = User.company_prodruct_by_user
    #render json: @user , status: :ok
    

    #@user = User.Product_Sale_by_user
    #render json: @user, :include => [:sales, :products]  , status: :ok
    


   # @user = User.Product_Sale_by_user_byID(1)
    #render json: @user, :include => [:sales, :products]  , status: :ok
    



    #PRODUCTOS en carrito
#    @user = User.cart_by_user
 #   render json: @user , status: :ok
    
    #PRODUCTOS ventas,  falta cambiar modleodddddddddddddddddddddd

    
    #publicaciones
    #@user = User.users_by_publications
    #render json: @user , status: :ok
            
    
    
   #buscar por rol
   #render json: User.users_by_rol("company"), status: :ok
   #render json: User.users_by_rol(1), status: :ok
       
  end

  # GET /users/1
  # GET /users/1.json
  def show
   #if  ! @user.admin?
    #  redirect_to users_url       
   #else
    render json: @user, status: :ok
   # end
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
