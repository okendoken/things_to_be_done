class ActivitiesController < ApplicationController
  include Voter

  def index
    if params[:task_id].present?
      @target = Task.find params[:task_id]
    else
      @target = Project.find params[:project_id]
    end
    respond_to do |format|
      format.js {render 'common/activities'}
      format.html {render 'common/activities'}
    end
  end

  def create
    @target = Task.find params[:task_id]
    status = params[:complete].present? ? ACTIVITY_STATUS[:completed] : ACTIVITY_STATUS[:in_progress]
    @target.commit_this(params[:activity][:text], current_user, status) if user_signed_in?
    if params[:state] == 'news'
      render 'common/news'
    elsif params[:state] == 'activities'
      render 'common/activities'
    end
  end

  def destroy
    activity = Activity.find params[:id]
    if can? :destroy, activity
      activity.destroy
    end
    @target = activity.participation.task
    if params[:state] == 'news'
      render 'common/news'
    elsif params[:state] == 'activities'
      render 'common/activities'
    end
  end

  def notsupport
    not_support
  end
end
