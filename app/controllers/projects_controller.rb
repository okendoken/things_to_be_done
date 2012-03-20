class ProjectsController < ApplicationController

  include ProjectTaskCommon

  def show
    @project = Project.find(params[:id])
  end

  def complete
    @target = Project.find params[:id]
    if can? :manage, @target
      @target.status = PROJECT_STATUS[:completed]
      @target.save
    end
    redirect_to @target
  end
end
