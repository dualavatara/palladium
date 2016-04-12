class TasksController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :init_references, only: [:new, :edit, :create, :update]
  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = Task.new
    @task.type = :service
    @task.requester ||= current_user
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  def update_state
    @task = Task.find(params[:id])
    @task.state = params[:state]
    @task.save
    redirect_to tasks_path
  end

  def init_references
    @users = @project.users
    @stories = @project.stories
  end

  private
  def task_params
    params.require(:task).permit(:name, :desc, :type, :requester_id, :story_id, owner_ids: [])
  end
end
