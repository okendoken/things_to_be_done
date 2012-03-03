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
      @user.user_info ||= UserInfo.new
      @user_info = @user.user_info
    end
  end

  def people
    if params[:task_id].present?
      @people = User.joins(:tasks).where(:'participations.task_id' => params[:task_id])
    end
  end
end
