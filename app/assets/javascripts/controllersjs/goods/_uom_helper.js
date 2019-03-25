
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

    is_dropdown: function(ref) {
        if ($(ref).context.id.search(/(_impexpcompany_id|_manufacturer_id)$/) > 0) {
            return true;
        } else {
            return false;
        }
    },

    fillup_dropdown_data: function(ref, data) {
        var toto = this;
        $(ref).children('option').each(function() {
            var id = $(this).val();
            if ($(this).is(':selected')) {
                // vlastnost je aktualne vybrata
                if (data.contains(id)) {
                    // vlasntost by bola duplicitne
                    data.remove(id);
                } else {
                    // tovar uz tuto vlastnost neobsahuje
                    if ($(ref).data("user-manipulated") == "1") {
                        
                    } else {
                        // kludne mozno odstranit
                        $(this).remove();
                    }
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
        /*
        var val = $(ref).val();
        var opts_count = $(ref).children('option').length;
        // ak v dropdown nevybrate nic a tovar ma len po jednej vlastnosti, nastavit tie
        if ((val == "")&&(opts_count <= 2)) {
            // presne 1 moznost na vyber - vybrat ju
            $(ref).children('option').each(function() {
                if ($(this).val != "") {
                    $(this).prop('selected', true);
                }
            });
            this.set_valid(ref, true);
        } else if ((val == "")&&(opts_count <= 1)&&(data.size == 0)) {
            // uz bude na vyber pravdepodobne len text validacie
            this.set_valid(ref, false);
            this.add_validation_msg(ref, 1);
        } else if (opts_count == 0) {
            // user pravdepodobne nieco pridal, nemanipuloval dropdownom
            // ale potom vsetko vyjebal
            this.set_valid(ref, false);
            //this.add_validation_msg(ref, 1);
            this.add_validation_msg(ref, 2);
        } else if ((opts_count <= 1)&&(data.size == 0)) {
            // to iste ako predtym moze byt
            this.set_valid(ref, false);
            this.add_validation_msg(ref, 1);
        } else if ((opts_count <= 1)&&(val == "")&&(data.size > 0)) {
            // dropdown je prazdny, ale uz bude nieco asi vybrate
            this.set_valid(ref, true);
        }
        */
    },

    user_manipulated: function(ref) {
        $(ref).data("user-manipulated", "1");
        /*if ($(ref).val() == "") {
            // pouzivatel vybral valid. chyby text alebo kokotinu
            // dojebat ho
            this.set_valid(ref, false);
        } else {

        }*/
    },

    set_valid: function(ref, bool) {
        if (bool) {
            $(ref).removeClass('error');
        } else {
            $(ref).addClass('error');
        }
    },

    add_validation_msg: function(ref, num) {
        var dropdown_text;
        var validation_text;
        var rgx = /good_uoms_attributes_[0-9]+_([a-z]+)_id/;
        var assoc = $(ref).attr('id').match(rgx)[1];
        //logger(assoc);
        switch(num) {
            case 1:
                validation_text = t('goods.new_form_texts.uom_' + assoc + '_removed_from_source');
                break;
            case 2:
                dropdown_text = t('goods.new_form_texts.uom_cannot_select_' + assoc);
                break;
        }

        if (dropdown_text !== undefined) {
            $(ref).append('<option class="validation_text">'+dropdown_text+'</option>');
        }

        if (validation_text !== undefined) {
            var txt = '<span class="errormessage">'+validation_text+'</span>';
            $(ref).closest('article').find('div.form_errors').append(txt);
        }
    },

    remove_validation_message: function(ref) {

    }

    /*trigger_checking_process: function(ref) {
        $('article.impexpcompany_select, article.manufacturer_select')
        .find('div.tablewrap > table > tbody > tr > td > input')
        .trigger('change');
    }*/

}
