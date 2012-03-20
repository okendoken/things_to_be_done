module ProjectsHelper
  def project_status(project)
    PROJECT_STATUS.index(project.status)
  end

  def project_status_icon(project)
    {
        :in_progress => 'icon-road',
        :completed => 'icon-ok-circle',
        :canceled => 'icon-ban-circle'
    }[project_status(project)]
  end
end
