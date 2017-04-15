class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken


  #include ActionController::MimeResponds
  #include ActionController::ImplicitRender
  ActiveModelSerializers.config.adapter = :json
  respond_to :json

  #protect_from_forgery with: :null_session, prepend: true 

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    
      if resource_class == User
        devise_parameter_sanitizer.permit(:sign_up,keys: [:name_user,:document,:image,:rol,:block,:sendEmail,:active]);
      end
  end
end
