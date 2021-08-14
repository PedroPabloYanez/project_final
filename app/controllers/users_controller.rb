class UsersController < ApplicationController
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to admin_path
    end
    
    def update_status
        user = User.find(params[:id])
        if user.admin?
            user.role = 0
        else
            user.role = 1
        end
        user.save
        flash[:success] = "status User is updated"
        redirect_to admin_path
    end
end
