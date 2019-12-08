function DateModeActivation() {
    this.checkbox = null;
    this.mode_select = null;
    this.init();
}

DateModeActivation.prototype = {
    constructor: DateModeActivation,

    init: function() {
        var totok = this;

        $(document).on('change', "input#q_search_date", function() {
            totok.changeInputProps(this);
            $(this).closest('form').submit();
        });
    },

    changeInputProps: function(ref) {
        var is_checked = $(ref).is(':checked');
        var el = $(document).find('span.date_select');

        if (is_checked === true) {
            el.children('select').removeAttr('disabled');
            el.siblings('span').children('label').removeClass('disabled');
        } else {
            el.children('select').attr('disabled', 'disabled');
            el.siblings('span').children('label').addClass('disabled');
        }
    }
}