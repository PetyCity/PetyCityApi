class CompanySerializer < ActiveModel::Serializer
    attributes :id, :nit, :name_comp, :address, :city, :phone, :permission, :user_id, :updated_at

end
