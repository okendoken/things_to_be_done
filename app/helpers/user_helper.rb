module UserHelper
  def is_current_user_page?(user)
    user_signed_in? and user.id == current_user.id
  end

  def UserHelper.nick(user)
    user_info = user.user_info
    if user_info.nick_name.present?
      return user_info.nick_name
    end
    if user_info.first_name.present? and user_info.last_name.present?
      return user_info.first_name + ' ' + user_info.last_name
    end
    user.display_name
  end
end
