module ProjectsHelper
  def available_projects
    return [] unless signed_in?
    current_user.projects
  end

  def current_project
    current_user.current_project
  end
end
