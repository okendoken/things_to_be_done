function popupCenter(url, width, height, name) {
    var left = (screen.width/2)-(width/2);
    var top = (screen.height/2)-(height/2);
    return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}

function changeLikerState(supports){
    if (supports){
        $("#supp-link").addClass("disabled");
        $("#dont-supp-link").removeClass("disabled");
    } else {
        $("#supp-link").removeClass("disabled") ;
        $("#dont-supp-link").addClass("disabled");
    }
}

function changeSmallLikerState(supports, dataId){
    if (supports){
        $("[data-toggle='small-supp-link-" + dataId + "']").addClass("disabled");
        $("[data-toggle='small-dont-supp-link-" + dataId + "']").removeClass("disabled");
    } else {
        $("[data-toggle='small-supp-link-" + dataId + "']").removeClass("disabled") ;
        $("[data-toggle='small-dont-supp-link-" + dataId + "']").addClass("disabled");
    }
}

$(function(){
    //if disabled class present then we don't need to let this btn or link being executed
    $("body").delegate("[class*='disabled']", "click", function(event){
        return false;
    });
    $("[data-toggle*='small-supp-link-'], [data-toggle*='small-dont-supp-link-']")
        .bind("ajax:success", function(evt, data, status, xhr){
            var response = $.parseJSON(xhr.responseText);
            changeSmallLikerState(response.vote_positive, response.target_id);
        });
    $(document).click(function(e) {
        //maybe better solution exists?
        if ($(e.target).closest('#login-dialog').length === 0) {
            $("#login-dialog").slideUp(230);
        }
        if ($(e.target).closest('#notifications-dialog').length === 0) {
            $("#notifications-dialog").slideUp(230);
        }
    });
});