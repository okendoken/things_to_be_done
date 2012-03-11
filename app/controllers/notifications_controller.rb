class NotificationsController < ApplicationController
  def index
    if user_signed_in?
      @events = current_user.related_events
    end
  end
end

