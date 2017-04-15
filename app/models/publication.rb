class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy
  has_many :c_user, through: :comment_Publications,source: :user
  
  validates :title, length: { minimum: 10 }, presence: true ,allow_blank: false
  validates :body_publication, presence: true ,allow_blank: true
  validates :user , presence: true

  #Queries

  default_scope {order("publications.title ASC")}

  #Para ver todas las publicaciones
  def self.only_publications(page = 1, per_page = 100)
    includes( :user,comment_Publications: :user)
    .paginate(:page => page,:per_page => per_page)
  end
  
  def self.publications_by_user(user, page = 1, per_page = 100)
    includes( :user,comment_Publications: :user)
    .where(publications: {
        user_id:  user
      })
  end
  #publicacion  en especifico con sus comentarios
  def self.publication_by_id(id)
    includes(:user,comment_Publications: :user)
    .find_by_id(id)    
  end

end
