class NotificationsController < ApplicationController

  def get_new_notifications
     if user_signed_in?
       @events_for_read = current_user.related_events.where(:read => false).order('created_at desc')
       @events_for_read_count = 0
       @events_for_read_count = @events_for_read.count
       @events_for_read = @events_for_read.limit(3)
       @events_for_read.each do |e|
         if can? :manage, e
           e.read = true
           e.save
         end
       end
       @unread_exists = true
       if(@events_for_read_count == 0)
         @unread_exists = false;
         @events_for_read = current_user.related_events.order('created_at desc').limit(3)
         @events_for_read_count = @events_for_read.count;
       end

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

