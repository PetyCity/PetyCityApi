class PublicationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body_publication, :user_id, :updated_at

end
