function UomClone() {
    this.init();
}

UomClone.prototype = {
    constructor: UomClone,

    init: function() {

    },

    make_new: function(ref) {
        var new_clone = ref.clone();
        var new_id = this.get_id_for_new();

        this.transfer_dropdown_data(new_clone, ref);
        this.rename_inputs(new_clone, new_id);
        this.clear_textfields(new_clone);

        $(document).find('aside').append(new_clone);
        $(document).find('aside').children(new_clone).trigger('UOMadded');
    },

    get_id_for_new: function() {
        var id = 0;
        $(document).find('aside').children('article').each(function() {
            var i = parseInt($(this).attr('id').replace(/\D+/, ""));
            if (i >= id) { id = i; }
        });
        return id+1;
    },

    clear_textfields: function(klon) {
        klon.find('input.uom_val').val('');
        klon.find('input.uom_multiplier').val('1');
    },

    rename_inputs: function(klon, new_id) {
        var toto = this;
        toto.replace_attrs(klon, 'id', new_id);
        klon.find('input').each(function() {
            toto.replace_attrs($(this), 'id', new_id);
            toto.replace_attrs($(this), 'name', new_id);
        });
        klon.find('label').each(function() {
            toto.replace_attrs($(this), 'for', new_id);
        });
        klon.find('select').each(function() {
            toto.replace_attrs($(this), 'id', new_id);
            toto.replace_attrs($(this), 'name', new_id);
        });
    },

    replace_attrs: function(elem, a, new_id) {
        var old_attr = elem.attr(a);
        elem.attr(a, old_attr.replace(/\d+/, new_id));
    },

    transfer_dropdown_data: function(klon, original) {
        klon.find('select').each(function() {
            var id = $(this).attr('id');
            var orig_data = original.find('#'+id).data();
            $(this).data(orig_data);
            logger(orig_data);
        });
    }

}
