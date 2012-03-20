class TasksController < ApplicationController

  include ProjectTaskCommon

  def show
    @task = Task.find(params[:id])
  end

  def participate
    if user_signed_in?
      @task = Task.find(params[:id])
      @task.participate_in_this(current_user)
    else
      render 'js/sign_in'
    end
  end

  def leave
    if user_signed_in?
      @task = Task.find(params[:id])
      @task.leave_this(current_user)
    else
      render 'js/sign_in'
    end
  end

  def complete
    @target = Task.find params[:id]
    if can? :manage, @target
      @target.status = TASK_STATUS[:completed]
      @target.save
    end
    redirect_to project_task_path(@target)
  end
end
