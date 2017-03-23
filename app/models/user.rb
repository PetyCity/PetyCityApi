class User < ApplicationRecord
  acts_as_token_authenticatable
  enum rol: [ :admin, :company, :customer ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
      
         
  #field :authentication_token


end

