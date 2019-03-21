function Uom() {
    this.HELPER;
    this.HELPER = new UomHelper();
    this.init();
}

Uom.prototype = {
    constructor: Uom,

    init: function() {
        var toto = this;

        // znema vyberu spravodajskej jednotky alebo dodavatela/odberatela pre tovar
        $('article.impexpcompany_select, article.manufacturer_select')
        .on('change', 'div.tablewrap > table > tbody > tr > td > input', function(e) {
            logger('impexp or manufacturer changed');
            toto.updateDropdowns(this, e);
        });

        // zmena v dropdown menu spravodajskej jednotky alebo dodavatela/odberatela pre danu mernu jednotku
        $(document)
        .on('change', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                logger('dropdown changed');
            }
        });

        // ide az po druhom kliknuti - vybrati moznosti
        $(document)
        .on('click', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                logger('dropdown clicked');
            }
        });

        // zaznamena zmenu este po odchode focusu z elementu, napr prepinanie tabom
        $(document)
        .on('focusout', 'article.uoms > div > div > select', function() {
            if (toto.HELPER.is_dropdown(this)) {
                logger('dropdown focused out');
            }
        });
    },

    updateDropdowns: function(ref, e) {
        var toto = this;
        var data = this.HELPER.collect_data_from_item_properties(e.delegateTarget);
        var dropdowns_class = this.HELPER.get_regex_for_dropdowns_class(e.delegateTarget);

        $(document).find('article.uoms').find('select').each(function() {
            if ($(this).attr('id').indexOf(dropdowns_class) > 0) {
                logger('dropdown found');
                toto.HELPER.fillup_dropdown_data(this, data);
                toto.HELPER.after_actions(this, data);
            }
        });
    },

    userManipulated: function(ref) {
        
    }
}
