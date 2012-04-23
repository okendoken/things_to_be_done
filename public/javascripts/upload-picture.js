$(function () {
    $('#avatar-upload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            alert(data.result.file_name + " uploaded!");
        }
    });
});