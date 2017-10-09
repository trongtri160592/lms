function isNullOrWhiteSpace( input ) {

    if (typeof input === 'undefined' || input == null) return true;

    return input.replace(/\s/g, '').length < 1;
}

jQuery(document).ready(function ($) {
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

    $('.select-file > .select-file-thumbs > .btn-select-file').click(function () {
        $(this).parent().find('input[type=file]').trigger('click');
    });

    $('.select-file > .select-file-thumbs > input[type=file]').change(function () {
        var fileInput = $(this);
        var errorMsg = $(this).parents('.select-file').find('.error-message');
        if (fileInput.length && fileInput[0].files && fileInput[0].files.length) {
            var fileSize = isNullOrWhiteSpace(fileInput.attr('data-size')) ? 3 : parseInt(fileInput.attr('data-size'));
            var fileInvalid = fileInput.attr('data-invalid');
            if (fileInput[0].files[0].size > (fileSize * 1024 * 1024)) {
                errorMsg.text(fileInvalid).show();
                fileInput.parents('.select-file').attr('data-select', 'removed');
                fileInput.val('');
            } else {
                var url = window.URL || window.webkitURL;
                var image = new Image();
                image.onload = function () {
                    errorMsg.text('').hide();
                    fileInput.parent().find('.icon').hide();
                    fileInput.parent().find('.img-thumbs').attr('src', URL.createObjectURL(fileInput[0].files[0])).show();
                    fileInput.parent().find('.btn-remove-file').show();
                    fileInput.parents('.select-file').attr('data-select', 'selected');
                };
                image.onerror = function () {
                    errorMsg.text(fileInvalid).show();
                    fileInput.parents('.select-file').attr('data-select', 'removed');
                    fileInput.val('');
                    fileInput.parent().find('.icon').show();
                    fileInput.parent().find('.img-thumbs').attr('src', '').hide();
                    fileInput.parent().find('.btn-remove-file').hide();
                };
                image.src = url.createObjectURL(fileInput[0].files[0]);
            }
        }
    });

    $('.select-file > .select-file-thumbs > .btn-remove-file').click(function (event) {
        $(this).parents('.select-file').attr('data-select', 'removed');
        $(this).parent().find('input[type=file]').val('');
        $(this).parent().find('.icon').show();
        $(this).parent().find('.img-thumbs').attr('src', '').hide();
        $(this).hide();
        event.stopPropagation();
    });

});