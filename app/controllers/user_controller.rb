class UserController < ApplicationController
  def show
    home_page_requested = !params[:id].present?
    redirect_to new_user_session_path if home_page_requested and not user_signed_in?
    if home_page_requested
      @user = current_user
    else
      @user = is_current_user_id?(params[:id]) ? current_user : User.find(params[:id])
    end
  end
end
