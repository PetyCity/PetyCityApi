class Api::V1::ContactsController < ApplicationController
 

   
  def create
   @message= contact_params
   message = ContactMailer.contact_us(@message)
   message.deliver_now  
   #puts @message
   render json: @message
  end


  private
   
    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :last_name, :phone, :city,:message)
    end
end
