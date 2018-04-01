function BelongsToDetachAssoc() {
    this.init();
}

BelongsToDetachAssoc.prototype = {
    constructor: BelongsToDetachAssoc,

    init: function() {
        $(document).on('click', 'button.detach_assoc', function() {
            var input_hidden = $(this).siblings('input');

        });
    }
}
