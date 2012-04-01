class NotificationsController < ApplicationController

  def get_new_notifications
     if user_signed_in?
      readed_ides = params[:readed_ides]
      if (readed_ides != nil)
        readed_ides.each do |id|
          event = RelatedEvent.find id
          if can? :update, event
            event.read = true
            event.save
          end
        end
      end
      # mark as read event, which user saw. receive ides from params
      @events = current_user.related_events
      respond_to do |format|
        format.js { render 'common/notifications' }
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

