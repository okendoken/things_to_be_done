class NotificationsController < ApplicationController
  def index
    if user_signed_in?
      @events = current_user.related_events
    end
  end

  def destroy
    event = RelatedEvent.find params[:id]
    if can? :destroy, event
      event.destroy
    end
    @target = comment.target
    respond_to do |format|
      format.js {render 'common/comments'}
      format.html {render 'common/comments'}
    end
  end
end

