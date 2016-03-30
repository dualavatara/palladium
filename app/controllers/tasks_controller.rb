class TasksController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index, :new, :create, :destroy]

  def index
  end

  def show
  end

  def new
    @task = Task.new
    @task.type = :service if !@story
    @users = @project.users
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project


    if @task.save
      redirect_to tasks_path
    else
      @users = @project.users
      render :new
    end
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:name, :desc, :type)
  end
end
