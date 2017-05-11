class Api::V1::ContactsController < ApplicationController
 before_action :select_contact_params, only: [:index,:show,:create,:search]
 before_action :set_user, only: [:index,:show,:search,:destroy,:update]
  #http://localhost:3000/api/v1/admin/users/7/contacts
  def index 
    render json: @contact_us , :include =>[:user], each_serializer: ContactSerializer,render_attribute:  @parametros
  end
  def show
   render json: @contact_us , :include =>[:user], each_serializer: ContactSerializer,render_attribute:  @parametros
  end
  #http://localhost:3000/api/v1/admin/users/7/contacts/search?case=2
  #http://localhost:3000/api/v1/admin/users/7/contacts/search?user=13&resolved=false
  #http://localhost:3000/api/v1/admin/users/7/contacts/search?resolved=false
  #http://localhost:3000/api/v1/admin/users/7/contacts/search?user=13
  def search    
    if params.has_key?(:case) 
         @contact_us = Contact.contact_by_case(params[:case])    
    elsif params.has_key?(:user) and params.has_key?(:resolved)
         @contact_us = Contact.contact_by_user_resolved(params[:user],params[:resolved])    
    elsif params.has_key?(:user) 
         @contact_us = Contact.contact_by_user(params[:user]) 
    elsif params.has_key?(:resolved)
         @contact_us = Contact.contact_by_resolved(params[:resolved])     
    end  
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]            
              if str == "created_at"||str == "document"|| str == "phone" || str == "city" || str == "id" || str =="email"|| str =="user_id"|| str =="resolved" 
                @contact_us =  @contact_us.order("#{str}": :desc)
                render json: @contact_us, :include =>[:user], each_serializer: ContactSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end
          else               
              if str == "created_at"||str == "document"|| str == "phone" || str == "city" || str == "id" || str =="email"|| str =="user_id"|| str =="resolved" 
                  @contact_us =  @contact_us.order("#{str}": :asc)
                  render json: @contact_us, :include =>[:user], each_serializer: ContactSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @contact_us, :include =>[:user], each_serializer: ContactSerializer,render_attribute:  @parametros
      
    end
  end

  def create
    @contact_us= Contact.new(contact_params)
    if params.has_key?(:user_id)
      @user = User.find_by_id(params[:user_id])
      @contact_us.name = @user.name_user
      @contact_us.document = @user.document
      @contact_us.email = @user.email      
      if @contact_us.save
        message = ContactMailer.contact_us_user_active(@contact_us)
        message.deliver_now 
        message = ContactMailer.confirm_user_active(@contact_us)
        message.deliver_now 
        render json: @contact_us, status: :created, each_serializer: ContactSerializer,render_attribute:  @parametros
      else
        render json: @contact_us.errors, status: :unprocessable_entity
      end
    else
      @contact_us.created_at =Time.now.to_s
      if @contact_us.valid?
        message = ContactMailer.contact_us(@contact_us)
        message.deliver_now 
        message = ContactMailer.confirm(@contact_us)
        message.deliver_now 
        render json: @contact_us, status: :created, each_serializer: ContactSerializer,render_attribute:  @parametros
      else
        render json: @contact_us.errors, status: :unprocessable_entity
      end
    end 
  end
  def update
    if @contact_us.update(contact_params)
      render status: :ok
    else
      render json: @contact_us.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @contact_us.destroy
  end
  private
    def set_user
        if params.has_key?(:user_id)         
            @user_admin = User.find_by_id(params[:user_id]) 
            if  @user_admin.nil? || !@user_admin.admin?#|| current_user.id != params[:user_id]) 
                  render status:  :forbidden
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                @contact_us = Contact.contact_by_case(params[:id])          
                if  @contact_us.nil?  
                       render status:   :not_found
                end
            else
                 @contact_us = Contact.contacts_all        
            end          
        else
           render status:  :forbidden
        end
      
    end
    def select_contact_params 
        @parametros =  "user,"+params[:select_contact].to_s  
    end
    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :document, :phone,:city,:email,:message,:user_id,:resolved)
    end
end
