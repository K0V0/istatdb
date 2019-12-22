function BelongsToDetachAssoc() {
    this.init();
}

BelongsToDetachAssoc.prototype = {
    constructor: BelongsToDetachAssoc,

    init: function() {
        $(document).on('click', 'button.detach_assoc', function() {
            var input_hidden = $(this).siblings('input');
            var val = input_hidden.val();
            if (val == "false") {
                input_hidden.val('true');
                $(this).closest('article').addClass('to_delete');
                $(this).text(t('actions.detach_assoc_cancel'));
            } else {
                input_hidden.val('false');
                $(this).closest('article').removeClass('to_delete');
                $(this).text(t('actions.detach_assoc'));
            }
        });
    }
}
