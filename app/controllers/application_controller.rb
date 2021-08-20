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

    def current_team 
        if current_team 
            team = Team.find_or_create_by(user_id: current_user.id, state: "created")
        end
    end

    protected

    def configure_permitted_parameters
        attributes = [:user_name,:user_photo, :image]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
end
