class UserController < ApplicationController
  def show
    home_page_requested = !params[:id].present?
    if home_page_requested and not user_signed_in?
      redirect_to new_user_session_path
    else
      if home_page_requested
        @user = current_user
      else
        @user = is_current_user_id?(params[:id]) ? current_user : User.find(params[:id])
      end
      @user_info = @user.user_info
    end
  end

  def upload

  end

end
