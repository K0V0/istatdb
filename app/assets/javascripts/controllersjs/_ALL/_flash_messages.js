function FlashMessages() {
    this.init();
}

FlashMessages.prototype = {
    constructor: FlashMessages,

    init: function() {
        var T = this;
        $(document)
            .on('click', 'body > div.flash_messages', function(e) {
                if (e.target == this) {
                    T.hideMessages();
                }
            });
        $(document)
            .on('click', 'button.cancel_flash, button.confirmation_cancel', function(e) {
                T.hideMessages();
            });
    },

    hideMessages: function() {
        $('body > div.flash_messages').children().remove();
        $('body > div.flash_messages').removeClass('visible');
    }
}
