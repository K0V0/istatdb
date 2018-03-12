function Confirmation() {
    this.link = null;
    this.init();
}

Confirmation.prototype = {
    constructor: Confirmation,

    init: function() {
        var T = this;
        /*$(document)
        .find('a')
        .filter(function() { return $(this).attr('data-confirmation') != undefined })
        .each(function(e) {
            //logger($(this).attr('data-confirmation'));
            //$(this).text('kokot');
            //logger('kokot');
            //e.preventDefault();
        });*/

        $(document).on('click', 'a', function(event) {
           // logger("iden 1");
            //event.preventDefault();
             //e.stopImmediatePropagation()
               // e.stopPropagation();
            if ($(this).attr('data-confirmation')) {
               // logger("iden");
                //$(this).removeAttr('data-remote');
                //$(this).removeAttr('data-method');

                event.preventDefault();
                //e.stopImmediatePropagation()
                //e.stopPropagation();
                T.link = $(this);
                T.showDialog();
                return false;
            }
        });

        //$(document).on('click', 'button.confirmation_ok', function(event) {

    },

    showDialog: function() {
        var T = this;
        var message = this.link.data('confirmation');
        var dialog = this.confirmationDialog(message);
        $(document)
            .find('div.flash_messages')
            .append(dialog)
            .addClass('visible');
        $(document)
            .find('div.flash_messages')
            .on('click', 'div > table > tbody > tr > td > button', function(e) {
                //logger($(e.target).attr('class'));
                if ($(e.target).hasClass('confirmation_ok')) {
                    T.confirm();
                } else {
                    T.cancel();
                }
            });
    },

    confirm: function() {
        logger('confirm');
    },

    cancel: function() {
        logger('cancel');
    },

    doAjax: function() {
        /*$.ajax({
          url: your_url,
          type: 'DELETE',
          success: function(result) {
            // Do something with the result
          }
        });*/
    },

    confirmationDialog: function(text="") {
        var html = "<div class=\"decorated_wrap shrinked\"><table class=\"for_dialogbox\"><caption>" + t('confirmation') + "</caption><thead></thead><tbody><tr class=\"confirmation\"><td>" + text + "</td></tr><tr class=\"buttons\"><td><button type=\"button\" class=\"button confirmation_ok\">" + t('ok') + "</button></td><td><button type=\"button\" class=\"button confirmation_cancel\">" + t('cancel') + "</button></td></tr></tbody></table></div>";
        return html;
    }
}


