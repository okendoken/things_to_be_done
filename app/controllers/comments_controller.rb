class CommentsController < ApplicationController
  def index
    if params[:task_id].present?
      @target = Task.find params[:task_id]
    else
      @target = Project.find params[:project_id]
    end
    respond_to do |format|
      format.js {render 'common/comments'}
      format.html {render 'common/comments'}
    end
  end

  def create
    if params[:task_id].present?
      @target = Task.find params[:task_id]
    else
      @target = Project.find params[:project_id]
    end
    @target.comments.create(:user => current_user, :text => params[:comment][:text])
  end
end
