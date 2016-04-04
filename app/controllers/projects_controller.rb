class ProjectsController < ApplicationController
  include CompaniesHelper
  before_action :current_user
  before_action :demand_admin, except: [:show]

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

  def destroy
    @project.destroy
    redirect_to company_path(@company)
  end

  def demand_admin
    @user = current_user
    @project = Project.find(params[:id]) if params[:id]
    @company = @project.company if @project
    @company = Company.find(params[:company_id]) if params[:company_id]
    # @company = Company.find(params[:id])
    redirect_to companies_path unless @company.admin?(@user)
  end



  private

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
