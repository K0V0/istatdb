//index, search, show, administrative, end_administrative

function SearchManufacturersSelect() {
    this.init();
}

SearchManufacturersSelect.prototype = {
    constructor: SearchManufacturersSelect,

    init: function() {
        var totok = this;
        var container = $(document).find('span#search_items_select_manufacturer');
        var detected_target = container.children('div.multiselect').children('span');

        container.on('click', function() {
            $(this).children('div.multiselect').toggleClass('open');
        });

        $(document).on('click', function(e) {
          if (e.target.id != 'search_items_select_manufacturer' && $(e.target).parents('#search_items_select_manufacturer').length == 0) {
            $(document).find('div.multiselect').removeClass('open');
          }
        });

        $(document).on('click', 'button#reset_manufacturers', function() {
            var chkbx = $(this).closest('div').find('input[type=checkbox]');
            chkbx.removeAttr('checked');
            $(this).closest('form').submit();
        });

    }
}
