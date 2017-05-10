class CommentProductSerializer < ActiveModel::Serializer
  attributes :id, :body_comment_product,:c_pro_votes_like,:c_pro_votes_dislike,:user_id
  belongs_to :product
  belongs_to :user

end
