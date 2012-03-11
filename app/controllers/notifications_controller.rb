class NotificationsController < ApplicationController
  def index
    if user_signed_in?
      @events = {:test => "I'm event"}
    end
  end
end

