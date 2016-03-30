class TasksController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index, :new, :create, :destroy]

  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = Task.new
    @task.type = :service if !@story
    @users = @project.users
    @task.requester ||= current_user
    @stories = @project.stories
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project

    if @task.save
      redirect_to tasks_path
    else
      @users = @project.users
      @stories = @project.stories
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:name, :desc, :type, :requester_id, :story_id)
  end
end
