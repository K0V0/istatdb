
function UomHelper() {
    this.init();
}

UomHelper.prototype = {
    constructor: UomHelper,

    init: function() {

    },

    collect_data_from_item_properties: function(ref) {
        var data = [];
        $(ref).find('div.tablewrap').find('input:checked').each(function() {
            var tmp = {
                id: $(this).attr('id').replace(/\D+/, ""),
                name: $(this).closest('td').next().children('label').text()
            }
            data.push(tmp);
        });
        //logger(data);
        return data;
    },

    get_regex_for_dropdowns_class: function(ref) {
        return $(ref).attr('id').replace(/(_select_\d+)$/, "") + "_id";
    }


}
