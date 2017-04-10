class Api::V1::PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :update, :destroy]

  # GET /publications
  def index
    @publications = Publication.only_publications
    render json: @publications, :include => []
  
    
    #@publications = Publication.publications_by_user(2)
    #render json: @publications
  
    #@publications = Publication.publicacion_by_id(1)
    #render json: @publications, :include => [:comment_Publications]  , status: :ok
       
  end




  # GET /publications/1
  def show
    @publicactions = Publication.publication_by_id(params[:id])
    render json: @publication
  end



  def publicationbyid
   
    @publications = Publication.publication_by_id(params[:id])
    render json: @publications, :include => [:comment_Publications, :user]  

  end

  # POST /publications
  def create
    @publication = Publication.new(publication_params)

    if @publication.save
      render json: @publication, status: :created, location: @publication
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /publications/1
  def update
    if @publication.update(publication_params)
      render json: @publication
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # DELETE /publications/1
  def destroy
    @publication.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def publication_params
      params.require(:publication).permit(:title, :body_publication, :user_id)
    end
end
