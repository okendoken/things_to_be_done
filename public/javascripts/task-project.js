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
    $("body").delegate("#comment_text", "click", function(){
        $("#new_comment input[type='submit']").removeClass("hide");
        $(this).attr("rows", 2);
    });
    $(document).click(function(e) {
        //maybe better solution exists?
        if ($(e.target).closest('#comment_text').length === 0 && $(e.target).closest("#new_comment input[type='submit']").length === 0 ) {
            $("#new_comment input[type='submit']").addClass("hide");
            $("#comment_text").attr("rows", 1);
        }
        if ($(e.target).closest('.manage-dialog').length === 0 ) {
            $(".manage-dialog").addClass("hide");
        }
    });
    $('[data-display="manage"]').click(function(){
        var $this = $(this),
            position = $this.position(),
            $dialog = $(".manage-dialog"),
            dialogPosition = {
                left: position.left - ($dialog.width() - $this.width() - 17),
                top: position.top + $this.height() + 10
            };
        $dialog.css(dialogPosition);
        $dialog.removeClass("hide");

        return false;
    });
});