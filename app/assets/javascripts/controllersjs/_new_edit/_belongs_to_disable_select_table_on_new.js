function BelongsToDisableSelectTableOnNew() {
    this.init();
}

BelongsToDisableSelectTableOnNew.prototype = {
    constructor: BelongsToDisableSelectTableOnNew,

    init: function() {
        this.watch();
    },

    watch: function() {
        $(document).on('change', 'input.allow_add_new', function() {
            var table = $(this).closest('article').find('table');
            if ($(this).first().is(':checked')) {
                table.addClass('disabled');
                //table.find('input:checked').prop('checked', false);
            } else {
                table.removeClass('disabled');
            }
        });
    }

}
