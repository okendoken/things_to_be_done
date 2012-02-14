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

$(function(){
    //if disabled class present then we don't need to let this btn or link being executed
    $("body").delegate("[class*='disabled']", "click", function(event){
    	return false;
    });
});