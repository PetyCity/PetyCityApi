class ContactMailer < ActionMailer::Base
  default from: "2017petcity@gmail.com"

  def contact_us(user)
     @user = user
       mail(to: "pethelp2017@gmail.com",
         subject: "Customer Support")
    
  end
end
