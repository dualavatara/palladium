class ActorsController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index, :new, :create]

  def index
    @actors = @project.actors
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)
    @actor.project = @project

    if @actor.save
      redirect_to project_actors_path(@project.id)
    else
      render :new
    end
  end

  def destroy
    @actor = Actor.find(params[:id])
    @actor.destroy
    redirect_to :back
  end

  private
  def actor_params
    params.require(:actor).permit(:name, :desc)
  end
end
