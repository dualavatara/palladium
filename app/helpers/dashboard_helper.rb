module DashboardHelper
  def user_projects
    current_user.projects
  end

  def features_num(project)
    project.features.count
  end

  def stories_num(project)
    project.stories.count
  end

  def tasks_num(project)
    project.tasks.count
  end
end
