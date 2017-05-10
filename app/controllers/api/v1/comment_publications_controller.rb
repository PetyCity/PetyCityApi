class Api::V1::CommentPublicationsController < ApplicationController
  before_action :set_comment_publication, only: [:show, :update, :destroy,:votes_dislike,
                                              :votes_like,:user_vote,:my_vote]
  after_action :actualizate_votes, only: [:user_vote ] 
  
  def show
    if params.has_key?(:user_id)
       @comment_publication = CommentPublication.find(params[:id])
       render json: @comment_publication, :include => []
    end
  end
  
  #/POST  /api/v1/costum/users/:user_id/publications/:publication_id/comment_publications/:id/votes
  # => para custummer 
  def user_vote
     if vote_params[:vote] == '0' || vote_params[:vote] == '1'   || vote_params[:vote] == '-1'       
          if  @user.customer? || @user.company_customer?#cliente y cliente compañia pueden votar 
                if vote_params[:vote] == '1'
                  
                    if !@user.voted_for? @comment_publication
                        @user.likes @comment_publication
                        @comment_publication.c_pu_votes_like = @comment_publication.c_pu_votes_like+1
                        render status: :ok 
                    else
                        if @user.voted_down_on? @comment_publication
                          @comment_publication.undisliked_by  @user
                          @user.likes @comment_publication
                          @comment_publication.c_pu_votes_dislike = @comment_publication.c_pu_votes_dislike-1
                          @comment_publication.c_pu_votes_like = @comment_publication.c_pu_votes_like+1
                          render status: :ok
                        else
                            render status: :forbidden #no puede votar dos veces   
                        end                        
                    end
                elsif vote_params[:vote] == '-1'
                    if @user.voted_for? @comment_publication
                        if @user.voted_down_on? @comment_publication
                           @comment_publication.undisliked_by  @user
                           @comment_publication.c_pu_votes_dislike = @comment_publication.c_pu_votes_dislike-1                         
                           render status: :ok
                        else
                          @comment_publication.unliked_by @user
                         @comment_publication.c_pu_votes_like = @comment_publication.c_pu_votes_like-1
                          render status: :ok       
                        end   
                    else
                         render status: :forbidden                     
                    end
                else
                    if !@user.voted_for? @comment_publication
                        @user.dislikes @comment_publication
                        @comment_publication.c_pu_votes_dislike = @comment_publication.c_pu_votes_dislike+1
                        render status: :ok
                    else
                        if @user.voted_up_on? @comment_publication
                          @comment_publication.unliked_by @user
                          @user.dislikes @comment_publication
                          @comment_publication.c_pu_votes_dislike = @comment_publication.c_pu_votes_dislike+1
                          @comment_publication.c_pu_votes_like = @comment_publication.c_pu_votes_like-1
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
 
  # /api/v1/costum/users/:user_id/publications/:publication_id/comment_publications/:id/my_vote
  def my_vote
     if !@user.voted_for? @comment_publication           
           render json:  false, status: :ok           
     else
           if @user.voted_up_on? @comment_publication                          
               render json: 1,  status: :ok
           else
               render json:  0,status: :ok   
           end
     end
  end

  # /api/v1/admin/users/:user_id/publications/:publication_id/comment_publications
  def create
   if params.has_key?(:user_id)
      @comment_publication = CommentPublication.new(comment_publication_params)
  
      if @comment_publication.save
        render json: @comment_publication, :include => [], status: :created
      else
        render json: @comment_publication, :include => [], status: :unprocessable_entity
      end
   end
  end

  # PATCH/PUT /comment_publications/1
  def update
    if @comment_publication.update(comment_publication_params)
      render json: @comment_publication, :include => []
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
      if params.has_key?(:user_id)         
            @user = User.find_by_id(params[:user_id]) 
            if  @user.nil?
                  render status:  :not_found
            end
          #  if  current_user.id != params[:user_id]) 
           #       render status:  :forbidden
           # end    
            if params.has_key?(:id)
                   
                @comment_publication =  CommentPublication.find_by_id(params[:id])     
                if  @comment_publication.nil?  
                       render status:   :not_found
                end
            else
              @comment_publications =  CommentPublication.all                              
            end          
        else            
            if params.has_key?(:id)                  
                 #if  current_user.id != params[:id] 
                 #       render status:  :forbidden
                 # end                     
                 @comment_publication =  CommentPublication.find_by_id(params[:id])  
                 if  @comment_publication.nil?
                       render status: :not_found
                 end
             else
                  @comment_publications =  CommentPublication.all
             end
         end 
    end

    def actualizate_votes   
             
      @comment_publication.update_columns(c_pu_votes_like: @comment_publication.c_pu_votes_like,c_pu_votes_dislike: @comment_publication.c_pu_votes_dislike)
    end
    
    # Only allow a trusted parameter "white list" through.
    def comment_publication_params
      params.require(:comment_publication).permit(:body_comment_Publication, :publication_id, :user_id)
    end
    def vote_params
      params.permit(:vote)
    end
end
