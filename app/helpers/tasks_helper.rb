module TasksHelper
  def task_status(task)
    TASK_STATUS.index(task.status)
  end

  def task_status_icon(task)
    {
        :in_progress => 'icon-road',
        :completed => 'icon-ok-circle',
        :canceled => 'icon-ban-circle'
    }[task_status(task)]
  end
end
