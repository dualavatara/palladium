class FeaturesController < ApplicationController
  before_action :find_project, only: [:index, :new]
  def index

    @features = @project.features
  end

  def new
    @feature = Feature.new
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
