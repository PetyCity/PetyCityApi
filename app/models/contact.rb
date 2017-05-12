class Contact < ApplicationRecord
  belongs_to :user
  validates :name, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { in: 5..30 }, presence: true

  validates :document, numericality: { only_integer: true ,
              message: "only allows numbers " },  length: { in: 5..14 },
              presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :city,  length: { in: 3..30 }, presence: true
  validates :phone, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { in: 6..20 }
          
  validates :message, presence: true ,length: { in: 5..800 }
  
  
  def self.contacts_all
    includes(:user)
    #.paginate(:page => page,:per_page => per_page)
  end
 
  def self.contact_by_case(val)
    includes(:user)
    .where(contacts: {
       id: val
    })
  end
  def self.contact_by_resolved(val)
    includes(:user)
    .where(contacts: {
       resolved: val
    })
    #.paginate(:page => page,:per_page => per_page)
  end
  def self.contact_by_user(val)
    includes(:user)
    .where(users: {
       id: val
    })
    #.paginate(:page => page,:per_page => per_page)
  end
  def self.contact_by_user_resolved(val1,val2)
    includes(:user)
    .where(users: {
       id: val1
    })
    .where(contacts: {
       resolved: val2
    })
    #.paginate(:page => page,:per_page => per_page)
  end
  
  
  
end
