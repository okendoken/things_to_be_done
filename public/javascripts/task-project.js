$(function(){
    $(".desc-extension-link").click(function(){
        $(".desc-sliced").toggleClass("extended");
        $(".desc-extension").toggleClass("hide");
        $(".desc-extension-link").toggleClass("hide");
        return false;
    });
    $("[data-activity-nav]").click(function(){
        $('[data-activity-nav] > span').addClass('label-info');
        $(this).children('span').removeClass('label-info');
    });
});