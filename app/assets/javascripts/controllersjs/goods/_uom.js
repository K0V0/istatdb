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
            //logger(e.delegateTarget);
            //logger(this);
            toto.updateDropdowns(this, e);
        })

        // zmena v dropdown menu spravodajskej jednotky alebo dodavatela/odberatela pre danu mernu jednotku
        $(document)
        .on('change', 'article.uoms > div > div > select', function() {
            if ($(this).attr('id').indexOf(/(_impexpcompany_id|_manufacturer_id)$/) > 0) {
                logger('dropdown changed');
            }
        })
    },

    updateDropdowns: function(ref, e) {
        var data = this.HELPER.collect_data_from_item_properties(e.delegateTarget);
        var dropdowns_class = this.HELPER.get_regex_for_dropdowns_class(e.delegateTarget);
        $(document).find('article.uoms').find('select').each(function() {
             //logger($(this));
             //logger(dropdowns_class);
            if ($(this).attr('id').indexOf(dropdowns_class) > 0) {
                logger('dropdown found');
                logger($(this));
            }
        });
    }
}
