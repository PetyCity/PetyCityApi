class ApplicationController < ActionController::API


  #include ActionController::MimeResponds
  #include ActionController::ImplicitRender
  ActiveModelSerializers.config.adapter = :json
  respond_to :json

end
