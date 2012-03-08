module UserHelper
  def is_current_user_content?(user)
    user_signed_in? and user.id == current_user.id
  end
end
