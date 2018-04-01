function Confirmation() {
    this.link = null;
    this.init();
}

Confirmation.prototype = {
    constructor: Confirmation,

    init: function() {
        var T = this;
        $(document).on('click', 'a', function(event) {
            if ($(this).attr('data-confirmation')) {
                event.preventDefault();
                T.link = $(this);
                T.showDialog();
                return false;
            }
        });
    },

    showDialog: function() {
        var T = this;
        var message = this.link.data('confirmation');
        var dialog = this.confirmationDialog(message);
        $(document)
            .find('div.flash_messages')
            .append(dialog)
            //.removeClass('novisible')
            .addClass('visible');
        $(document)
            .find('div.flash_messages')
            .on('click', 'div > table > tfoot > tr > td > button', function(e) {
                if ($(e.target).hasClass('confirmation_ok')) {
                    T.confirm();
                } else {
                    T.cancel();
                }
            });
    },

    hideDialog: function() {
        $('body > div.flash_messages').children().remove();
        $('body > div.flash_messages').removeClass('visible');
    },

    confirm: function() {
        this.doAjax();
    },

    cancel: function() {

    },

    doAjax: function() {
        var T = this;
        $.ajax({
          url: T.link.attr('href'),
          type: 'DELETE',
          success: function(result) {
            T.hideDialog();
          }
        });
    },

    confirmationDialog: function(text="") {
        var html = "<div class=\"decorated_wrap shrinked\"><table class=\"for_nontabular with_controls confirmation\"><caption>" + t('confirmation') + "</caption><thead></thead><tbody><tr><td>" + text + "</td></tr></tbody><tfoot><tr><td colspan=\"10\"><button type=\"button\" class=\"button confirmation_ok\">" + t('ok') + "</button> <button type=\"button\" class=\"button confirmation_cancel\">" + t('cancel') + "</button></td></tr></tfoot></table></div>";
        return html;
    }
}


