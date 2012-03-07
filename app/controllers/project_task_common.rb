module ProjectTaskCommon
  def activities
    respond_to do |format|
      format.js {render 'common/activities'}
      format.html {render 'common/activities'}
    end
  end
end