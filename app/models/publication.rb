class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
  
  validates :title, length: { minimum: 120 }, presence: true ,allow_blank: false
  validates :body, presence: true ,allow_blank: true 
  
end
