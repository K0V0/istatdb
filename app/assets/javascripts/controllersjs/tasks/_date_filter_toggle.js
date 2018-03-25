function DateFilterToggle() {
    this.checkbox = null;
    this.init();
}

DateFilterToggle.prototype = {
    constructor: DateFilterToggle,

    init: function() {
        var totok = this;
        this.checkbox = $(document).find("input#q_search_date");

        this.checkbox.on('change', function() {
            totok.changeInputProps(this);
        });
    },

    changeInputProps: function(ref) {
        var is_checked = $(ref).is(':checked');

        if (is_checked === true) {
            $(document).find('span.date_select > select').removeAttr('disabled');
            $(document).find('label[for=q_date_filter]').removeClass('disabled');
        } else {
            $(document).find('span.date_select > select').attr('disabled', 'disabled');
            $(document).find('label[for=q_date_filter]').addClass('disabled');
        }
        // to let remembered choice after page reload, do search to send required param "search_both=>1"
        // to server side
        $(document).find("form#task_search").submit();
    }
}
