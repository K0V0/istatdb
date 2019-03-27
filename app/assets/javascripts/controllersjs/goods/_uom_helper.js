
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

    get_regex_for_attributes_class: function(ref) {
        rgx = /[a-z_]+[0-9]+_([a-z]+)_id/;
        return $(ref).attr('id').match(rgx)[1] + "_select";
    },

    get_regex_for_validation_messages_class: function(ref) {
        var rgx = /good_uoms_attributes_[0-9]+_([a-z]+)_id/;
        return $(ref).attr('id').match(rgx)[1];
    },

    is_dropdown: function(ref) {
        if ($(ref).context.id.search(/(_impexpcompany_id|_manufacturer_id)$/) > 0) {
            return true;
        } else {
            return false;
        }
    },

    fillup_dropdown_data: function(ref, data) {
        var toto = this;
        var tmpdata = new UomData(data.get());
        $(ref).children('option').each(function() {
            var id = $(this).val();
            if ($(this).is(':selected')) {
                // vlastnost je aktualne vybrata
                if (tmpdata.contains(id)) {
                    // vlasntost by bola duplicitne
                    tmpdata.remove(id);
                } else {
                    // tovar uz tuto vlastnost neobsahuje
                    if ($(ref).data("user-manipulated") == "1") {

                    } else {
                        // kludne mozno odstranit
                        $(this).remove();
                    }
                }
            } else {
                if (tmpdata.contains(id)) {
                    tmpdata.remove(id);
                } else {
                    $(this).remove();
                }
            }
        });
        $(ref).append(tmpdata.generate_options());
    },

    set_user_manipulated: function(ref) {
        if ($(ref).val() != "") {
            $(ref).data("user-manipulated", "1");
        }
    },

    get_user_manipulated: function(ref) {
        if ($(ref).data("user-manipulated") == "1") {
            return true;
        } else {
            return false;
        }
    },

    get_is_option_active: function(ref) {
        //if ($(ref).val() == $(ref).closest('select').val()) {
        if ($(ref).is(':selected')) {
            return true;
        } else {
            return false;
        }
    },

    set_valid: function(ref, bool) {
        if (bool) {
            $(ref).removeClass('error');
            this.remove_validation_messages(ref);
        } else {
            $(ref).addClass('error');
        }
    },

    add_validation_msg: function(ref, num) {
        var dropdown_text;
        var validation_text;
        var assoc = this.get_regex_for_validation_messages_class(ref);

        this.remove_validation_messages(ref);

        switch(num) {
            // polozka odstranena z atributov tovaru
            case 1:
                validation_text = t('goods.new_form_texts.uom_' + assoc + '_removed_from_source');
                break;
            // nula atributov tovaru
            case 2:
                validation_text = t('goods.new_form_texts.uom_cannot_select_' + assoc);
                dropdown_text = " - - - - - - - - ";
                break;
        }

        if (dropdown_text !== undefined) {
            if ($(ref).children('option.validation_text').length <= 0) {
                $(ref).append('<option class="validation_text" value="0">'+dropdown_text+'</option>');
            }
        }

        if (validation_text !== undefined) {
            var txt = '<span class="errormessage uom_'+assoc+'">'+validation_text+'</span>';
            $(ref).closest('article').find('div.form_errors').append(txt);
        }
    },

    remove_validation_messages: function(ref) {
        var assoc = this.get_regex_for_validation_messages_class(ref);
        $(ref).closest('article').find('span.errormessage.uom_'+assoc).remove();
    },

    unlock_actions: function(ref) {
        var uom = $(ref).closest('article');
        var uoms = $(ref).closest('aside').find('article');
        var valid = true;

        uom.find('input[type=text]').each(function() {
            if (!/^\d+$/.test($(this).val())) { valid = false; }
        });

        uom.find('select').each(function() {
            if (!/^[^0][0-9]*$/.test($(this).val())) { valid = false; }
        });

        if (valid) {
            uom.find('button.add_uom').attr('disabled', false);
        } else {
            uom.find('button.add_uom').attr('disabled', true);
        }

        /*if (uoms.length > 1) {
            uoms.find('button.remove_uom').attr('disabled', false);
        } else {
            uoms.find('button.remove_uom').attr('disabled', true);
        }*/

    }

}
