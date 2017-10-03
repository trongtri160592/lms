jQuery(document).ready(function ($) {

    // /quan-ly-nguoi-dung
    $(':file').on('change', function () {
        var file = this.files[0];
        if (file.size > 5 * 1024 * 1024) {
            alert('max upload size is 5M')
        }
    });

    $('#btn-excel-submit').on('click', function () {
        $.ajax({
            url: '/add-user',
            type: 'POST',

            // Form data
            data: new FormData($('form')[0]),

            // Tell jQuery not to process data or worry about content-type
            // You *must* include these options!
            cache: false,
            contentType: false,
            processData: false,

            // Custom XMLHttpRequest
            xhr: function () {
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) {
                    // For handling the progress of the upload
                    myXhr.upload.addEventListener('progress', function (e) {
                        if (e.lengthComputable) {
                            $('progress').attr({
                                value: e.loaded,
                                max: e.total,
                            });
                        }
                    }, false);
                }
                return myXhr;
            },
            success: function (data) {

            },
            error: function (jqXHR, textStatus, errorThrown) {

            }
        });
    });
    // end /quan-ly-nguoi-dung

    // quan-ly-nhom-nguoi-dung
    $('#btn-save-group').on('click', function () {
        var name = $('#user-group-name').val();
        var role_id_array = [];
        $('#role-form input:checkbox:checked').each(function () {
            role_id_array.push($(this).val()); // do your staff with each checkbox
        });

        $.ajax({
            url: '/groups/new',
            type: 'POST',
            // Form data
            data: {"name": name.toString(), "role": role_id_array},

            success: function (data) {
                $('#add-user-group-modal').modal('hide');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#add-user-group-modal').modal('hide');
            }
        });
    });
    $('#add-user-group-modal').on('hidden.bs.modal', function (e) {
        $(this)
            .find("input,textarea,select")
            .val('')
            .end()
            .find("input[type=checkbox], input[type=radio]")
            .prop("checked", "")
            .end();
    })
});