function Confirmation() {
    this.init();
}

Confirmation.prototype = {
    constructor: Confirmation,

    init: function() {
        var T = this;
        $(document).on('click', 'a', function() {
            if ($(this).attr('data-confirmation')) {
                T.showDialog($(this));
            }
        });
    },

    showDialog: function(ref) {

    }
}
