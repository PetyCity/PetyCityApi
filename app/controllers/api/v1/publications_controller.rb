 class Api::V1::PublicationsController < ApplicationController
  before_action :set_publication, only: [:index,:show, :create,:update, :destroy,:my_publications]
  before_action :select_publication_params, only: [:index,:show, :my_publications, :create,:search]

  # /api/v1/admin/users/:user_id/publications/
  # /api/v1/publications/
  def index
    if params.has_key?(:user_id)
        render json: @publications, :include => [:user,comment_Publications: :user], each_serializer: PublicationSerializer,render_attribute:  @parametros
    else
        render json: @publications, :include => [:user], each_serializer: PublicationSerializer,render_attribute:  @parametros
    end     
  end
  # /api/v1/admin/users/:user_id/publications/id
  # /api/v1/publications/id
  def show
    if params.has_key?(:user_id)
        render json: @publication, :include => [:user,comment_Publications: :user], each_serializer: PublicationSerializer,render_attribute:  @parametros
    else
        render json: @publication, :include => [:user], each_serializer: PublicationSerializer,render_attribute:  @parametros
    end
  end


#/api/v1/admin/users/:user_id/users/:id/my_publications
# 
  def my_publications   
   if params.has_key?(:user_id) #ADMIN 
        @user = User.find_by_id(params[:user_id]) 
       if  @user.admin?
           @publications = Publication.publications_by_user(params[:id])   
           render json: @publications, :include => [:user,comment_Publications: :user], each_serializer: PublicationSerializer,render_attribute:  @parametros
       else
            render status: :forbidden             
       end
   else #Costummer
       @user = User.find_by_id(params[:id]) 
      if  @user.customer?
           @publications = Publication.publications_by_user(params[:id])   
           render json: @publications, :include => [:user,comment_Publications: :user]  , each_serializer: PublicationSerializer,render_attribute:  @parametros
       else
            render status: :forbidden             
       end
   end
  end


  #/api/v1/costum/users/:user_id/publications
  def create
            render status: :forbidden     
    else#usuario cliente
            @publication = Publication.new(publication_params)
            if @publication.save
              render  status: :created
            else
              render  status: :unprocessable_entity
            end
    end  
   
  end

  # PATCH/PUT /api/v1/costum/users/:user_id/publications/:id
  # /api/v1/costum/users/:user_id/publications/:id
  def update
    if  !@user.customer?#solo el cliente puede crear
            render status: :forbidden     
    else#usuario cliente
            if @publication.update(publication_params)
              render json: @publication, status: :ok
            else
              render json: @publication.errors, status: :unprocessable_entity
            end
    end  
    
  end

  # DELETE /publications/1
  def destroy
    if  @user.company? #La compañia  no puede borrar nada
          render status: :forbidden  
    elsif  @user.admin?#Administrador puede borar todas                    
           if @publication.destroy                            
               render status: :ok
           else
               render status: :unprocessable_entity 
           end          
    else#el usuario borra las publicaciones de el
          if @publication.user_id == Integer(params[:user_id])  #El usuario de la publicacion es el mismo usuario logueado
              if @publication.destroy                            
                 render status: :ok
              else
                  render status: :unprocessable_entity 
              end              
          else
            render status: :forbidden #no la pede borrar
          end 
    end
  end


  def search    
    
    if params.has_key?(:q)
        @publications = Publication.publications_by_name("%#{params[:q]}%")
#       render json: @products, :include => [:product]##un helado mayor
    #          
    else
        @publications = Publication.only_publications 
    
    end

    
    if params.has_key?(:sort)
          str = params[:sort]
          if params[:sort][0] == "-"
              str= str[1,str.length]
             
              if str == "created_at"||str == "title"|| str == "user_id" || str == "id"
               
                @publications =  @publications.order("#{str}": :desc)
                render json: @publications, :include =>[:product], each_serializer: PublicationSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end
          else               
              if str == "created_at"||str == "title"|| str == "user_id" || str == "id"
               
                 @publications =  @publications.order("#{str}": :asc)
                  render json: @publications, :include =>[:publication], each_serializer: PublicationSerializer,render_attribute:  @parametros
              else
                  render status:  :bad_request
              end  
          end
    else
      render json: @publications, :include =>[:publication], each_serializer: PublicationSerializer,render_attribute:  @parametros
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :not_found
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                   
                 @publication = Publication.publication_by_id(params[:id])       
                if  @publication.nil?  
                       render status:   :not_found
                end
            else
              @publications = Publication.only_publications                               
            end          
        else            
            if params.has_key?(:id)
                  
                 #if  current_user.id != params[:id]) 
                 #       render status:  :forbidden
                 # end  |                   
                 @publication = Publication.publication_by_id(params[:id])   
                 if  @publication.nil?
                       render status: :not_found
                 end
             else
                  @publications = Publication.only_publications 
             end
         end
    end
    def select_publication_params 
        @parametros =  "publication,"+params[:select_publication].to_s  
    end
    # Only allow a trusted parameter "white list" through.
    def publication_params
      params.require(:publication).permit(:title, :body_publication, :user_id,:image_company)
    end
end
