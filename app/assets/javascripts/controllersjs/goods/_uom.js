function Uom() {
    this.HELPER;
    this.HELPER = new UomHelper();
    this.UOM_CLONE;
    this.UOM_CLONE = new UomClone();
    this.init();
}

Uom.prototype = {
    constructor: Uom,

    init: function() {
        var toto = this;

        $(document)
        .on('UOMadded', 'article.uoms', function() {
            toto.HELPER.unlock_actions($(this).children('div').first());
            toto.HELPER.delete_actions($(this).children('div').first());
        });

        $(document)
        .on('input', 'article.uoms > div > div > input', function() {
            toto.HELPER.unlock_actions(this);
            toto.HELPER.delete_actions(this);
        });

        // znema vyberu spravodajskej jednotky alebo dodavatela/odberatela pre tovar
        $('article.impexpcompany_select, article.manufacturer_select')
        .on('change', 'div.tablewrap > table > tbody > tr > td > input', function(e) {
            toto.updateDropdowns(this, e);
        });

        // zmena v dropdown menu spravodajskej jednotky alebo dodavatela/odberatela pre danu mernu jednotku
        $(document)
        .on('change', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                toto.validate(this);
            }
        });

        $(document)
        .on('DOMSubtreeModified', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                toto.validate(this);
                toto.HELPER.unlock_actions(this);
            }
        });

        // ide az po druhom kliknuti - vybrati moznosti
        $(document)
        .on('click', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                toto.HELPER.set_user_manipulated(this);
            }
            toto.HELPER.unlock_actions(this);
        });

        // zaznamena zmenu este po odchode focusu z elementu, napr prepinanie tabom
        $(document)
        .on('focusout', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
            }
        });

        $(document).on('click', 'button.add_uom', function() {
            toto.addUom(this);
        });

        $(document).on('click', 'button.remove_uom', function() {
            toto.removeUom(this);
        });

        $(document).on('click', 'button.restore_uom', function() {

        });

        $(document).on('click', 'u.cancel_uom_delete', function() {
            toto.cancelDeleteOnUploaded(this);
        });
    },

    updateDropdowns: function(ref, e) {
        var toto = this;
        var data = this.HELPER.collect_data_from_item_properties(e.delegateTarget);
        var dropdowns_class = this.HELPER.get_regex_for_dropdowns_class(e.delegateTarget);

        $(document).find('article.uoms').find('select').each(function() {
            if ($(this).attr('id').indexOf(dropdowns_class) > 0) {
                toto.HELPER.fillup_dropdown_data(this, data);
                toto.validate(this);
            }
        });
    },

    removeUom: function(ref) {
        var uom = $(ref).closest('article');
        var uoms = $(ref).closest('aside').find('article');
        if ($('body').is('.edit, .update')) {
            if (uom.find('input.delete_uom').attr('uom_id') != "") {
                uom.find('input.delete_uom').val('1');
                uom.addClass('to_delete');
            } else {
                uom.remove();
            }
        } else {
            if (uoms.length > 1) {
                uom.remove();
            } else {
                uom.find('input.uom_val').val('');
            }
        }
    },

    cancelDeleteOnUploaded: function(ref) {
        var uom = $(ref).closest('article');
        uom.children('input.delete_uom').val('false');
        uom.removeClass('to_delete');
    },

    addUom: function(ref) {
        this.UOM_CLONE.make_new($(ref).closest('article'));
    },

    validate: function(ref) {
        var toto = this;
        var datasource_elem = $(document).find('article.' + toto.HELPER.get_regex_for_attributes_class(ref));
        var data = toto.HELPER.collect_data_from_item_properties(datasource_elem);
        toto.HELPER.set_valid(ref, true);

        if (data.size() <= 0) {
            // nie su vybrate ziadne atributy pre tovar
            toto.HELPER.set_valid(ref, false);
            toto.HELPER.add_validation_msg(ref, 2);
        } else {
            $(ref).children('option').each(function() {
                if (data.contains($(this).val())) {
                    // ok, zdroj dat obsahuje tuto polozku
                } else {
                    // ak puzivatel rucne manipuloval s dropdownom
                    if (toto.HELPER.get_user_manipulated(ref)) {
                        // ak porovnavane data nie je len popisok, placeholder bez hodnoty
                        if ($(this).val() != "") {
                            // ak je chybajuca polozka ta vybrata
                            if (toto.HELPER.get_is_option_active(this)) {
                                toto.HELPER.set_valid(ref, false);
                                toto.HELPER.add_validation_msg(ref, 1);
                            } else {

                            }
                        } else {

                        }
                    } else {

                    }
                }
            });
        }
    }

}
