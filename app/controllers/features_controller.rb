class FeaturesController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index, :new, :create]

  def index
    @features = @project.features
  end

  def new
    @feature = Feature.new
    @feature.project = @project
  end

  def show
  end

  def create
    @feature = Feature.new(feature_params)
    @feature.project = @project
    if @feature.save
      redirect_to project_features_path(@project.id)
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to :back
  end

  private
  def feature_params
    params.require(:feature).permit(:name, :desc)
  end
end
