class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy

  validates :title, length: { minimum: 10 }, presence: true ,allow_blank: false
  validates :body_publication, presence: true ,allow_blank: true
  validates :user , presence: true

  #Queries

  default_scope {order("publications.title ASC")}

  #Para ver todas las publicaciones
  def self.only_publications(page = 1, per_page = 10)
    select("publications.*").paginate(:page => page,:per_page => per_page)
  end
  #ver publicaciones por cada usuaro
  def self.publications_by_user(user, page = 1, per_page = 10)
    where(publications: {
        user_id:  user.paginate(:page => page,:per_page => per_page)
      })
  end
  #publicacion  en especifico con sus comentarios
  def self.publication_by_id(id)
    includes(comment_Publications: :user)
    .find_by_id(id)    
  end

end
