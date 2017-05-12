class CompanyMailer < ApplicationMailer
  default from: ENV["EMAIL_USERNAME"]

  def authorize_company(company)
     @company = company
       mail(to: @company.user.email,
         subject: "PetCity_authorize_company #{@company.name_comp}")
  end
  def disavow_company(company)
     @company = company
       mail(to: @company.user.email,
         subject: "PetCity_disavow_company #{@company.name_comp} ")
  end
end
