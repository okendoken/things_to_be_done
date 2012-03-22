class ProjectsController < ApplicationController

  include ProjectTaskCommon

  def show
    @project = Project.find(params[:id])
  end

  def manage
    @target = Project.find params[:id]
    if can? :manage, @target
      if not params[:complete].nil?
        @target.status = PROJECT_STATUS[:completed]
      elsif not params[:cancel].nil?
        @target.status = PROJECT_STATUS[:canceled]
      elsif not params[:resume].nil?
        @target.status = PROJECT_STATUS[:in_progress]
      end
      @target.save
    end
    redirect_to @target
  end
end
