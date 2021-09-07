class HomeController < ApplicationController
    #before_action :authenticate_user!
    def index
        if user_signed_in?
            @projects = Project.all
            @teams = Team.all
        end    
    end

    def admin
        unless current_user.admin?
          redirect_to root_path, notice: "Access blocked"
        end
        @users = User.all
      end
  end