
function UomHelper() {
    this.init();
}

UomHelper.prototype = {
    constructor: UomHelper,

    init: function() {

    },

    collect_data_from_item_properties: function(ref) {
        var data = new UomData();
        $(ref).find('div.tablewrap').find('input:checked').each(function() {
            data.add({
                id: $(this).attr('id').replace(/\D+/, ""),
                name: $(this).closest('td').next().children('label').text()
            });
        });
        return data;
    },

    get_regex_for_dropdowns_class: function(ref) {
        return $(ref).attr('id').replace(/(_select_\d+)$/, "") + "_id";
    },

    is_dropdown: function(ref) {
        if ($(ref).context.id.search(/(_impexpcompany_id|_manufacturer_id)$/) > 0) {
            return true;
        } else {
            return false;
        }
    },

    set_dropdown_state: function(ref, state) {
        $(ref).data("state", state);
    },

    get_dropdown_state: function(ref) {
        $(ref).data("state");
    },

    fillup_dropdown_data: function(ref, data) {
        $(ref).children('option').each(function() {
            var id = $(this).val();
            if ($(this).is(':selected')) {
                if (data.contains(id)) {
                    data.remove(id);
                }
            } else {
                if (data.contains(id)) {
                    data.remove(id);
                } else {
                    $(this).remove();
                }
            }
        });
        $(ref).append(data.generate_options());
    },

    after_actions: function(ref, data) {
        if (($(ref).val() == "")&&(data.size() <= 2)) {
            $(ref).children('option').each(function() {
                if ($(this).val != "") {
                    $(this).prop('selected', true);
                }
            });
        }
    }

}
