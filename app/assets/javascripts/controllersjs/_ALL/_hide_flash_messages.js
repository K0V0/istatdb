function HideFlashMessages() {
    this.init();
}

HideFlashMessages.prototype = {
    constructor: HideFlashMessages,

    init: function() {
        $(document).on('click', 'body > div.flash_messages', function(e) {
            if (e.target == this) {
                $(this).remove();
            }
        });
       $(document).on('click', 'button.cancel_flash', function(e) {
            $('body > div.flash_messages').remove();
       });
    }
}
