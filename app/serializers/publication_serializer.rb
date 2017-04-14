class PublicationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body_publication, :user_id, :updated_at,:image_publication
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
  has_many :c_user, through: :comment_Publications,source: :user
end
