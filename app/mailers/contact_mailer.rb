class ContactMailer < ActionMailer::Base
  default from: ENV["EMAIL_USERNAME"]

  def contact_us(user)
     @user = user
       mail(to: ENV["EMAIL_USERNAME_HELP"],
         subject: "Support")
  end
  def contact_us_user_active(user)
     @user = user
       mail(to: ENV["EMAIL_USERNAME_HELP"],
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
