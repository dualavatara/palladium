class RequirementsController < ApplicationController
  before_action :find_project, only: [:index, :new]
  def index

    @requirements = @project.requirements
  end

  def new
    @requirement = Requirement.new
  end

  def show
  end

  def create
  end

  def update
  end

  def find_project
    @project = params[:project_id] ?
        Project.find(params[:project_id]) :
        current_user.current_project
  end
end
