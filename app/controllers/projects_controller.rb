class ProjectsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @company = Company.find(params[:company_id])
    @project = Project.new
  end

  def create
    @company = Company.find(params[:company_id])
    @project = Project.new(project_params)
    @project.company = @company

    if @project.save
      #in success add this project to admin user
      current_user.projects << @project

      # set as current if there is no current_projects
      current_user.current_project = @project unless current_user.current_project?

      current_user.save

      redirect_to company_path(@company)
    else
      render :new
    end
  end

  def update
  end

  private

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
