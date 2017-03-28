class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
  
  validates :title, length: { minimum: 10 }, presence: true ,allow_blank: false
  validates :body_publication, presence: true ,allow_blank: true 
  validates :user , presence: true
  
  #Queries
  
  default_scope {order("publications.title ASC")}
  
  #Para ver todas las publicaciones 
  def self.only_publications()
    select("publications.*") 
  end
  #ver publicaciones por cada usuaro
  def self.publications_by_user(user)
    where(publications: {
        user_id:  user
      })
  end
  #publicacion  en especifico con sus comentarios
  def self.publicacion_by_id(id)
    includes(:comment_Publications)
    .find_by_id(id)
  end

end
