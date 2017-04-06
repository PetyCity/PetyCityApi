class CommentProductSerializer < ActiveModel::Serializer
  attributes :id, :body_comment_product,:user_id, :updated_at
  
end
