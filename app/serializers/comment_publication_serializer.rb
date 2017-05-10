class CommentPublicationSerializer < ActiveModel::Serializer
  attributes :id, :body_comment_Publication, :publication_id, :user_id,:c_pu_votes_like,:c_pu_votes_dislike 
  belongs_to :publication
  belongs_to :user
 
end
