class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end

  def participate
    if user_signed_in?
      @task = Task.find(params[:id])
      unless @task.participates_in_this?(current_user)
        @task.participate_in_this(current_user)
        #later roma will replace type participate_in_task with constant Notification.participate_in_task
        Notification.create_notification("participate_in_task", current_user, @task)
      end
    else
      render 'js/sign_in'
    end
  end

  def leave
    if user_signed_in?
      @task = Task.find(params[:id])
      if part = Participation.where(:user_id => current_user.id, :task_id => @task.id)[0]
        part.destroy
      end
    else
      render 'js/sign_in'
    end
  end
end
