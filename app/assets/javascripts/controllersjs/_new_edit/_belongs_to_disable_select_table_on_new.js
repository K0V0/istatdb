function BelongsToDisableSelectTableOnNew() {
    this.init();
}

BelongsToDisableSelectTableOnNew.prototype = {
    constructor: BelongsToDisableSelectTableOnNew,

    init: function() {
        var section = $(document)
            .find('input[name=assoc-type]')
            .filter(function() {
                return $(this).val() == 'belongs_to';
            })
            .closest('article');
        this.watch(section);
    },

    watch: function(section) {
        var T = this;
        section.on('change',
            'div > div > input.allow_add_new',
            function() {
                var table = $(this).closest('article').find('table');
                if ($(this).first().is(':checked')) {
                    table.addClass('disabled');
                    table.find('input:checked').prop('checked', false);
                } else {
                    table.removeClass('disabled');
                }
            }
        );
    }
}
