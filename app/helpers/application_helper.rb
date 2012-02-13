module ApplicationHelper

  def support_path(target)
    '/support' + target_path(target)
  end

  def not_support_path(target)
    '/notsupport' + target_path(target)
  end

  private

  def target_path(target)
    target.is_a?(Task) ? url_for([target.project, target]) : url_for(target)
  end
end
