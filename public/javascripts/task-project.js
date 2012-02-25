$(function(){
    $(".desc-extension-link").click(function(){
        $(".desc-sliced").toggleClass("extended");
        $(".desc-extension").toggleClass("hide");
        $(".desc-extension-link").toggleClass("hide");
        return false;
    });
});