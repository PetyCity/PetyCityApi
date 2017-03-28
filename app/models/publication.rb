class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
  
  validates :title, length: { minimum: 10 }, presence: true ,allow_blank: false
  validates :body_publication, presence: true ,allow_blank: true 
  validates :user , presence: true
  
end
