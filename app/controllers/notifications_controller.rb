class NotificationsController < ApplicationController

  def index
    if user_signed_in?
      # mark as read event, which user saw. receive ides from params
      @events = current_user.related_events;
      respond_to do |format|
        format.js {render 'common/notifications'}
      end
    end
  end

  #def destroy
  #  event = RelatedEvent.find params[:id]
  #  if can? :destroy, event
  #    event.destroy
  #  end
  #  @events = current_user.related_events
  #  respond_to do |format|
  #    format.js {render 'common/notifications'}
  #    format.html {render 'common/notifications'}
  #  end
  #end

end

