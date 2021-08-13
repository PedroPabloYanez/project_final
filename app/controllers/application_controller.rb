class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    #layout :layout_by_resource

    # private

    # def layout_by_resource
    #     if devise_controller?
    #         "devise"
    #     else
    #         "application"
    #     end
    # end

    protected

    def configure_permitted_parameters
        attributes = [:user_name, :user_photo]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
end
