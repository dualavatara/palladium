module ProjectsHelper
  def available_projects
    return [] unless signed_in?
    current_user.projects
  end

  def current_project
    current_user.current_project
  end

  def find_project
    @project = params[:project_id] ?
        Project.find(params[:project_id]) :
        current_user.current_project
  end
end
