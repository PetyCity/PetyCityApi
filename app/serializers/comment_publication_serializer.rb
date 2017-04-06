class CommentPublicationSerializer < ActiveModel::Serializer
  attributes :id, :body_comment_Publication, :publication_id, :user_id, :updated_at
  belongs_to :publication
  belongs_to :user
 
end
