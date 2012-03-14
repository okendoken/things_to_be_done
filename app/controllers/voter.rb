module Voter
  def support
    handle_request(true)
  end

  def not_support
    handle_request(false)
  end

  private

  def handle_request(positive)
    if user_signed_in?
      if request.path.include? 'comments'
        comment = Comment.find(params[:id])
        vote = comment.vote_for_this(current_user, positive)
        @supports = vote.positive?
        @target = comment
      elsif params[:task_id].present?
        task = Task.find(params[:task_id])
        vote = task.vote_for_this(current_user, positive)
        @supports = vote.positive?
        @target = task
      elsif params[:project_id].present?
        project = Project.find(params[:project_id])
        vote = project.vote_for_this(current_user, positive)
        @supports = vote.positive?
        @target = project
      end
      respond_to do |format|
        format.js {render 'vote/support'}
        format.json{render :json => {:target_id => @target.id, :vote_positive => @supports}}
      end
    else
      render 'js/sign_in'
    end
  end
end