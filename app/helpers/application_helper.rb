module ApplicationHelper

  def support_path(target)
    target.is_a?(Task) ? support_route_path([target.project, target]) : support_route_path(target)
  end

  def not_support_path(target)
    target.is_a?(Task) ? not_support_route_path([target.project, target]) : not_support_route_path(target)
  end

  def display_vk_login?
    I18n.locale == :ru
  end

  def target_users_path(target, block_id)
    if target.is_a?(Task)
      block_id == 'supporters' ? supporters_path([target.project, target]) : participators_path([target.project, target])
    else
      block_id == 'supporters' ? supporters_path(target) : participators_path(target)
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
    object.is_a?(Task) ? comments_project_task_path(object.project, object) : comments_project_path(object)
  end

  def activities_path(object)
    object.is_a?(Task) ? activities_project_task_path(object.project, object) : activities_project_path(object)
  end

end
