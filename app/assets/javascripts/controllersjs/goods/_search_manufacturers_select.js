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

        /*$(document).on('click', function(e){
            console.log(e.target);
           if(!$(e.target).is(detected_target)){
             $("div.multiselect").removeClass("open");
           }
        });*/

        container.on('click', function() {
            $(this).children('div.multiselect').toggleClass('open');
        });

        $(document).find('div.multiselect').children('div').on('click', function(e) {
            e.stopPropagation();
        });

        $(document).on('change', 'div.multiselect', function(e) {
          console.log('changed');
          $(document).find("form#good_search").submit();
           });

        /*$(document).on({
           click: function(){
              $("div.multiselect").removeClass("open");
           }
        },":not('span#search_items_select_manufacturer')");*/

    }


}
