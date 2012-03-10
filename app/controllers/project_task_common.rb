module ProjectTaskCommon
  def activities
    respond_to do |format|
      format.js {render 'common/activities'}
      format.html {render 'common/activities'}
    end
  end

  def news
    if params[:project_id].present?
      @target = Task.find params[:id]
    else
      @target = Project.find params[:id]
    end
    respond_to do |format|
      format.js {render 'common/news'}
      format.html {render 'common/news'}
    end
  end
end