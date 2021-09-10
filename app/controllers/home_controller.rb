class HomeController < ApplicationController
    #before_action :authenticate_user!
    
    def index
        @projects = Project.all
        @teams = Team.all
       
    end

    def admin
        unless current_user.admin?
          redirect_to root_path, notice: "Access blocked"
        end
        @users = User.all
        if params[:user_name].present?
            @users = @users.where("user_name LIKE ?", "%#{params[:user_name]}%")
        end   
    end

    def destroy_user_admin
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_path, notice: 'User dasdasdasdasd deleted.'
    end

    
end