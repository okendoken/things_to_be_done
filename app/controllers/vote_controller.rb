class VoteController < ApplicationController

  def support
    handle_request(true)
  end

  def not_support
    handle_request(false)
  end

  private

  def handle_request(positive)
    if user_signed_in?
      if params[:task_id].present?
        task = Task.find(params[:task_id])
        vote_for_task(task, positive)
        @target = task
      elsif params[:project_id].present?
        project = Project.find(params[:project_id])
        vote_for_project(project, positive)
        @target = project
      end
      respond_to do |format|
        format.js {render 'vote/support'}
        format.json{render :json => {:target_id => @target.id, :vote_positive => @supports}}
      end
    else
      render 'vote/sign_in'
    end
  end

  def vote_for_project(project, positive = true)
    if vote = project.user_vote(current_user)
      if positive ^ vote.positive?
        vote.positive = positive
        vote.save
      end
    else
      vote = project.vote_for_this(current_user, positive)
    end
    #todo someday we can rerender only current user instead of fetching all
    @supporters = project.users
    @supports = vote.positive?
  end

  def vote_for_task(task, positive = true)
    if vote = task.user_vote(current_user)
      if positive ^ vote.positive?
        vote.positive = positive
        vote.save
      end
    else
      vote = task.vote_for_this(current_user, positive)
    end
    @supporters = task.users
    @supports = vote.positive?
  end
end