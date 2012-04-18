module ApplicationHelper

  include EventEnvironment

  def support_path(target)
    if target.is_a? Task
      support_route_path([target.project, target])
    elsif target.is_a? Project
      support_route_path(target)
    elsif target.is_a? Comment
      support_comment_path(target)
    elsif target.is_a? Activity
      support_activity_path(target)
    end
  end

  def not_support_path(target)
    if target.is_a? Task
      not_support_route_path([target.project, target])
    elsif target.is_a? Project
      not_support_route_path(target)
    elsif target.is_a? Comment
      notsupport_comment_path(target)
    elsif target.is_a? Activity
      notsupport_activity_path(target)
    end
  end

  def display_vk_login?
    I18n.locale == :ru
  end

  def target_users_path(target, block_id)
    if target.is_a?(Task)
      block_id == 'supporters' ? supporters_project_task_path(target.project, target) :  participants_project_task_path(target.project, target)
    else
      block_id == 'supporters' ? supporters_project_path(target) : participants_project_task_path(target)
    end
  end

  def format_date(date)
    if date > 1.day.ago
      date.strftime("%H:%M")
    else
      date.strftime("%b %d, %y")
    end
  end

  def comments_path(object)
    object.is_a?(Task) ? project_task_comments_path(object.project, object) : project_comments_path(object)
  end

  def activities_path(object)
    object.is_a?(Task) ? project_task_activities_path(object.project, object) : project_activities_path(object)
  end

  def all_news_path(object)
    object.is_a?(Task) ? news_project_task_path(object.project, object) : news_project_path(object)
  end

  def manage_path(object)
    object.is_a?(Task) ? manage_project_task_path(object.project, object) : manage_project_path(object)
  end

  def prepare_for_path(object)
    if object.is_a?(Task)
      [object.project, object]
    elsif object.is_a?(Project)
      [object]
    elsif object.is_a?(Activity)
      prepare_for_path object.participation.task
    elsif object.is_a?(Comment)
      prepare_for_path object.target
    end
  end

  def prepare_title(object)
    if object.is_a?(Task)
      object.title
    elsif object.is_a?(Project)
      object.title
    elsif object.is_a?(Activity)
      object.participation.task.title
    elsif object.is_a?(Comment)
      prepare_title(object.target)
    end
  end

  def symbol_event_type(event)
    clazz = event.readable.class.name.downcase.to_sym
    DB_EVENT_TYPES[clazz].index(event.e_type)
  end

  def is?(target, status)
    target.is_a?(Task) ? task_status(target) == status : project_status(target) == status
  end

  def prepare_url(string)
    if string.start_with? "http://"
      string
    else
      "http://" + string
    end
  end
end
