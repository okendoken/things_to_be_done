$(".notifications-list").html("<%= escape_javascript(render :partial => 'partials/all_notifications', :locals => {:events => @events})%>");

