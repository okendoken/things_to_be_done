$(".notifications-list").html("<%= escape_javascript(render :partial => 'partials/all_notifications', :locals => {:events => @events})%>");
$(".notifications-count-container").html("<%= escape_javascript(render :partial => 'partials/notifications_count')%>");
