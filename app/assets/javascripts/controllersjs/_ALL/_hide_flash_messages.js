function HideFlashMessages() {
    this.init();
}

HideFlashMessages.prototype = {
    constructor: HideFlashMessages,

    init: function() {
        var T = this;
        $(document).on('click', 'body > div.flash_messages', function(e) {
            if (e.target == this) {
                T.hideMessages();
            }
        });
       $(document).on('click', 'button.cancel_flash', function(e) {
             T.hideMessages();
       });
    },

    hideMessages: function() {
        $('body > div.flash_messages').children().remove();
        $('body > div.flash_messages').removeClass('visible');
        /*$('body > div.flash_messages').one('transitionend', function() {
           $(this).addClass('novisible');
        });*/
    }
}
