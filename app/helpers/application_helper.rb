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

end
