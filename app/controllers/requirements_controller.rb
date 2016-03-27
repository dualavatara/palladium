class RequirementsController < ApplicationController
  def index
    @project = params[:project_id] ?
        Project.find(params[:project_id]) :
        current_user.current_project
    @requirements = @project.requirements
  end

  def new
  end

  def show
  end

  def create
  end

  def update
  end
end
