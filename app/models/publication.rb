class Publication < ApplicationRecord
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
end
