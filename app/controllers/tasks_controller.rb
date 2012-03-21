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

  def manage
    @target = Task.find params[:id]
    if can? :manage, @target
      if not params[:complete].nil?
        @target.status = TASK_STATUS[:completed]
      elsif not params[:cancel].nil?
        @target.status = TASK_STATUS[:canceled]
      elsif not params[:resume].nil?
        @target.status = TASK_STATUS[:in_progress]
      end
      @target.save
    end
    redirect_to project_task_path(@target)
  end
end
