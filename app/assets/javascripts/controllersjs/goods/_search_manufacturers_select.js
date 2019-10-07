//index, search, show, administrative, end_administrative

function SearchManufacturersSelect() {
    this.init();
}

SearchManufacturersSelect.prototype = {
    constructor: SearchManufacturersSelect,

    init: function() {
        var checkbox_used_last = false;

        $(document).on('click', function(e) {
            var container = $(document).find('div.multiselect');
            var target = $(e.target);
            var form = container.closest('form');

            if (target.is(container) || target.is(container.children('span'))) {
                container.toggleClass('open');
            } else if (!target.is('input[type=checkbox]')) {
                container.removeClass('open');
                if (target.is('label')) {
                    if (target.closest(container).length > 0) {
                        e.preventDefault();
                        container.find('input[type=checkbox]').removeAttr('checked');
                        target.siblings('input[type=checkbox]').prop('checked', true);
                        form.submit();
                    }
                } else if (checkbox_used_last) {
                    form.submit();
                } 
            } else if (target.is('input[type=checkbox]')) {
                $(document).find('button#confirm_manufacturers').removeClass('novisible');
                checkbox_used_last = true;
            }

            if (container.find('input:checked').length > 0) {
                $(document).find('button#reset_manufacturers').removeClass('novisible');
            } else {
                $(document).find('button#reset_manufacturers').addClass('novisible');
            }
        });

        $(document).on('click', 'button#reset_manufacturers', function() {
            var chkbx = $(this).closest('div').find('input[type=checkbox]');
            chkbx.removeAttr('checked');
            $(this).closest('form').submit();
        });

        $(document).on('click', 'button#confirm_manufacturers', function() {
            $(this).closest('form').submit();
        });
    }
}
