//index, search, show, administrative, end_administrative

function MultiselectHandler() {
    this.form = {};
    this.container = {};
    this.container_ids = [];
    this.init();
}

MultiselectHandler.prototype = {
    constructor: MultiselectHandler,

    init: function() {
        var toto = this;
        var checkbox_used_last = false;
        var toto = this;

        $(document).on('click', function(e) {
            toto.container = $(document).find('div.multiselect');
            toto.form = toto.container.closest('form');
            toto.container.each(function() {
                toto.container_ids.push(this.id);
            });
            var target = $(e.target);
            var current_container_id = (target.filter('div.multiselect').length <= 0) ?  target.closest('div.multiselect').attr('id') : e.target.id;
            var current_container = $('#'+current_container_id+'');
            var target = $(e.target);

            if (target.is(current_container) || target.is(current_container.children('span'))) {
                current_container.toggleClass('open');
                toto.container.not(current_container).removeClass('open');
            } else if (!target.is('input[type=checkbox]')) {
                if (target.is('label')) {
                    if (target.closest(current_container).length > 0) {
                        e.preventDefault();
                        current_container.find('input[type=checkbox]').removeAttr('checked');
                        target.siblings('input[type=checkbox]').prop('checked', true);
                        toto.form.submit();
                    }
                } else if (checkbox_used_last) {
                    toto.container.removeClass('open');
                    toto.form.submit();
                } else {
                    toto.container.removeClass('open');
                }
            } else if (target.is('input[type=checkbox]')) {
                current_container.find('button#confirm_multiselect').removeClass('novisible');
                checkbox_used_last = true;
            }

            if (current_container.find('input:checked').length > 0) {
                $(document).find('button#reset_multiselect').removeClass('novisible');
            } else {
                $(document).find('button#reset_multiselect').addClass('novisible');
            }
        });

        $(document).on('click', 'button#reset_multiselect', function() {
            var chkbx = $(this).closest('div').find('input[type=checkbox]');
            chkbx.removeAttr('checked');
            $(this).closest('form').submit();
        });

        $(document).on('click', 'button#confirm_multiselect', function() {
            $(this).closest('form').submit();
        });
    }
}
