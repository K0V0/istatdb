function HideFlashMessages() {
    this.init();
}

HideFlashMessages.prototype = {
    constructor: HideFlashMessages,

    init: function() {
        $(document).on('click', 'body > div.flash_messages', function(e) {
            $(this).remove();
        });
         $(document).on('click', 'body > div.flash_message > div', function(e) {
            e.stopPropagation();
        });
    }
}
