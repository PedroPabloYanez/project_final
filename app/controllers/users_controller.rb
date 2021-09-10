class UsersController < ApplicationController
    before_action :authenticate_user!
    def index
        #@users = User.all
        @users = User.order(:user_name).page(params[:page]).per(10)
        if params[:user_name].present?
            @users = @users.where("user_name LIKE ?", "%#{params[:user_name]}%")
          end 
    end

    def dashboard_user   
    end
   
    # def destroy
    #     @user = User.find(params[:id])
    #     @user.destroy
    #     redirect_to admin_path, notice: 'User was deleted.'
    # end

    
    def update_status
        user = User.find(params[:id])
        if user.admin?
            user.role = 0
        else
            user.role = 1
        end
        user.save
        redirect_to admin_path, notice: 'User is Admin.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def user_params
        params.require(:user).permit(:avatar)
      end 
end
