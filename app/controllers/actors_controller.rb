class ActorsController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:index]

  def index
    @actors = @project.actors
  end
end
