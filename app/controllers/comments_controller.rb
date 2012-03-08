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
    @target.comments.create!(:user => current_user, :text => params[:comment][:text]) if user_signed_in?
  end

  def destroy
    comment = Comment.find params[:id]
    if can? :destroy, comment
      comment.destroy
    end
    @target = comment.target
    respond_to do |format|
      format.js {render 'common/comments'}
      format.html {render 'common/comments'}
    end
  end
end
