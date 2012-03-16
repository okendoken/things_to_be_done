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
    @target.commit_this(params[:activity][:text], current_user) if user_signed_in?
    if params[:state] == 'news'
      render 'common/news'
    elsif params[:state] == 'activities'
      render 'common/activities'
    end
  end

  def destroy
    comment = Comment.find params[:id]
    if can? :destroy, comment
      comment.destroy
    end
    @target = comment.target
    if params[:state] == 'news'
      render 'common/news'
    else
      render 'comments/create'
    end
  end

  def notsupport
    not_support
  end
end
