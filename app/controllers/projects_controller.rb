class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  

  # GET /projects or /projects.json
  def index
    @projects = Project.all
    @project = Project.new
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  def like
    @project = Project.find(params[:id])
    if current_user.voted_up_on? @project
      @project.downvote_by current_user
    elsif current_user.voted_down_on? @project
      @project.upvote_by current_user
    else #not voted
      @project.upvote_by current_user
    end
    respond_to do |format|
     format.js
    end 
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
    #@teams = Team.where('id = ?', current_user.team_id)
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    #@teams = current_user.teams
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project = current_user.projects.build(project_params)
    #@project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        ProjectMailer.project_create(current_user).deliver_later
        
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { head :no_content }
        format.js {render :create}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
        format.js {render :update}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
       
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :status, :initial_date, :finish_date, :team_id, :user_id, :status)
    end
end
