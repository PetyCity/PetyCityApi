class CommentProductSerializer < ActiveModel::Serializer
  attributes :id, :body_comment_product,:user_id
  belongs_to :product
  belongs_to :user

end
