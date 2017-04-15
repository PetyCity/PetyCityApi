class Api::V1::CommentPublicationsController < ApplicationController
  before_action :set_comment_publication, only: [:show, :update, :destroy]

  
  # GET /comment_publications/1
  def show
    if params.has_key?(:user_id)
       @comment_publication = CommentPublication.find(params[:id])
       render json: @comment_publication
    end
  end

  # /api/v1/admin/users/:user_id/publications/:publication_id/comment_publications
  def create
   if params.has_key?(:user_id)
      @comment_publication = CommentPublication.new(comment_publication_params)
  
      if @comment_publication.save
        render json: @comment_publication, status: :created
      else
        render json: @comment_publication.errors, status: :unprocessable_entity
      end
   end
  end

  # PATCH/PUT /comment_publications/1
  def update
    if @comment_publication.update(comment_publication_params)
      render json: @comment_publication
    else
      render json: @comment_publication.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comment_publications/1
  def destroy
    @comment_publication.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_publication
      @comment_publication = CommentPublication.find(params[:id])
       #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end   
    end

    # Only allow a trusted parameter "white list" through.
    def comment_publication_params
      params.require(:comment_publication).permit(:body_comment_Publication, :publication_id, :user_id)
    end
end
