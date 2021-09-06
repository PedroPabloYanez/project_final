class TeamsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_team, only: %i[ show edit update destroy]
  

  # GET /teams or /teams.json
  def index
    @teams = Team.all
    if params[:name].present?
      @teams = @teams.where("name LIKE ?", "%#{params[:name]}%")
    end 
  end
  
  # GET /teams/1 or /teams/1.json
  def show
    @users = User.all
    
    if params[:user_name].present?
      @users = @users.where("user_name LIKE ?", "%#{params[:user_name]}%")
    end 
    
  end

  def add_member
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    if @team.users.include?(@user)
      redirect_to team_path, notice: "El usuario ya existe en el equipo"
    else
      @team.users << @user
      redirect_to team_path, notice: "El usuario ha sido añadido"
    end
  end

  def delete_member
    team = Team.find(params[:id])
    user = User.find(params[:member_id]) 
    team.users.destroy(user)
    redirect_to team_path, notice: "El usuario ha sido Eliminado"
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: root_path }
        format.js {render :create}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: root_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to root_path, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: root_path }
        format.js {render :update}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: root_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :color, :user_name)
    end 

    
      
end
