class ContactMailer < ActionMailer::Base
  default from: "2017petcity@gmail.com"

  def contact_us(user)
     @user = user
       mail(to: "pethelp2017@gmail.com",
         subject: "Support")
  end
  def contact_us_user_active(user)
     @user = user
       mail(to: "pethelp2017@gmail.com",
         subject: "Client Support")
  end
  def confirm(user)
     @user = user
       mail(to: @user.email,
         subject: "PetCity_Confirm message")
  end
  def confirm_user_active(user)
     @user = user
       mail(to: @user.email,
         subject: "PetCity_Confirm message #{@user.name} ")
  end
end
