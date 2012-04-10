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

  def participators
    if params[:task_id].present?
      @people = User.joins(:tasks).where(:'tasks.slug' => params[:task_id])
    end
    render 'people'
  end

  def supporters
    if params[:task_id].present?
      @people = User.joins(:voted_tasks).where(:'tasks.slug' => params[:task_id])
    end
    if params[:project_id].present?
      @people = User.joins(:voted_projects).where(:'projects.slug' => params[:project_id])
    end
    render 'people'
  end
end
