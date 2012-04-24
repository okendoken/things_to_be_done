class ProjectsController < ApplicationController

  include ProjectTaskCommon

  def show
    @project = Project.find(params[:id])
  end

  def manage
    @target = Project.find params[:id]
    if can? :manage, @target
      if not params[:complete].nil?
        @target.change_status :completed, current_user
      elsif not params[:cancel].nil?
        @target.change_status :canceled, current_user
      elsif not params[:resume].nil?
        @target.change_status :in_progress, current_user
      end
    end
    redirect_to @target
  end

  def tasks
    @project = Project.find params[:id]
    tasks = @project.tasks
    if params[:status] == 'completed'
      tasks = tasks.where(:status => TASK_STATUS[:completed])
    end
    if params[:order] == 'votes'
      tasks = @project.most_valuable_tasks
    elsif params[:order] == 'updated'
      tasks = tasks.order("updated_at desc")
    end
    @tasks = tasks
  end

  def supporters
    @people = User.joins(:voted_projects).where(:'projects.slug' => params[:id])
    render 'user/people'
  end

  def upload
    @project = Project.find params[:id]
    if can? :manage, @project
      @project.avatar = params[:picture]
      if @project.save
        unless env["HTTP_ACCEPT"] and env["HTTP_ACCEPT"].include?('application/json')
          response.headers['Content-Type'] = 'text/plain'
        end
        render :template => 'projects/upload', :formats => [:js]
      end
    else
      render :text => "you can't do that =("
    end
  end
end
