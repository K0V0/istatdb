function uoms() {
	this.UD_MANUFACTURER = null;
	this.UD_IMPEXPCOMPANY = null;
	this.selects = '.uoms_impexpcompany_select > select, .uoms_manufacturer_select > select';
	this.source_checkboxes = '#impexpcompany_select input, #manufacturer_select input'

	this.init();
	this.events();
}

uoms.prototype = {
	constructor: uoms,

	init: function() {
		this.UD_MANUFACTURER = new uomsManufacturerImpexpcompanyOptionsHandler('manufacturer');
		this.UD_IMPEXPCOMPANY = new uomsManufacturerImpexpcompanyOptionsHandler('impexpcompany');
	},

	events: function() {
		var TOTO = this;
		$(document).on('click', 'button.add_uom', function() {
			TOTO.add_uom($(this));
		});
		$(document).on('click', 'button.remove_uom', function() {
			
		});
		$(document).on('change', this.selects, function() {
			TOTO.toggle_add_next_button($(this));
		});
		$(document).on('change', this.source_checkboxes, function() {
			$('.uoms').each(function() {
				TOTO.toggle_add_next_button($(this).find(TOTO.selects));
			});
		})
	},

	add_uom: function(context) {
		var clone = context.closest('article').clone();
		clone.find('.uom_val').val('');
		clone.find('.uom_multiplier').val('1');
		clone.insertBefore('form > article:last-child');
	},

	toggle_add_next_button: function(context) {
		var is_empty = false;
		context.closest('article').find(this.selects).each(function() {
			if ($(this).val() == '') {
				is_empty = true;
			}
		});

		var btn = context.closest('article').find('button.add_uom');
		if (!is_empty) {
			btn.removeAttr('disabled');
		} else {
			btn.attr('disabled', 'disabled');
		}
	} 

}