module ProjectTaskCommon
  def comments
    if params[:project_id].present?
      @target = Task.find params[:id]
    else
      @target = Project.find params[:id]
    end
    respond_to do |format|
      format.js {render 'common/comments'}
      format.html {render 'common/comments'}
    end
  end

  def activities
    respond_to do |format|
      format.js {render 'common/activities'}
      format.html {render 'common/activities'}
    end
  end
end