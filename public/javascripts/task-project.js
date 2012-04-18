$(function(){
    $(".desc-extension-link").click(function(){
        $(".desc-sliced").toggleClass("extended");
        $(".desc-extension").toggleClass("hide");
        $(".desc-extension-link").toggleClass("hide");
        return false;
    });
    $("body").on("click", "[data-activity-nav]", function(){
        $('[data-activity-nav] > span').addClass('label-info');
        $(this).children('span').removeClass('label-info');
    });
    $("body").on("click", ".form-new-news textarea",  function(){
        $(".form-new-news input[type='submit']").removeClass("hide");
        $(this).attr("rows", 2);
    });
    $(document).click(function(e) {
        //maybe better solution exists?
        if ($(e.target).closest('.form-new-news textarea').length === 0 && $(e.target).closest(".form-new-news input[type='submit']").length === 0 ) {
            $(".form-new-news input[type='submit']").addClass("hide");
            $(".form-new-news textarea").attr("rows", 1);
        }
    });
});