class ProjectsController < ApplicationController

  include ProjectTaskCommon

  def show
    @project = Project.find(params[:id])
  end
end
