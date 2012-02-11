class VoteController < ApplicationController
  before_filter :authenticate_user!

  def support
    handle_request(true)
  end

  def not_support
    handle_request(false)
  end

  private

  def handle_request(positive)
    if params[:task_id].present?
      task = Task.find(params[:task_id])
      vote_for_task(task, positive)
    elsif params[:id].present?
      project = Project.find(params[:id])
      vote_for_project(project, positive)
    end
    render 'vote/support'
  end

  def vote_for_project(project, positive = true)
    if vote = project.votes.where(:user_id => current_user.id)[0]
      if positive ^ vote.positive?
        vote.positive = positive
        vote.save
      end
    else
      project.vote_for_this(current_user, positive)
    end
  end

  def vote_for_task(task, positive = true)
    if vote = task.votes.where(:user_id => current_user.id)[0]
      if positive ^ vote.positive?
        vote.positive = positive
        vote.save
      end
    else
      task.vote_for_this(current_user, positive)
    end
  end
end