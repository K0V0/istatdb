// new, edit

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
			TOTO.toggle_remove_button($(this));
		});
		$(document).on('click', 'button.remove_uom', function() {
			TOTO.remove_uom($(this));
		});
		$(document).on('change', this.selects, function() {
			TOTO.toggle_add_next_button($(this));
		});
		$(document).on('change', this.source_checkboxes, function() {
			$('.uoms').each(function() {
				TOTO.toggle_add_next_button($(this).find(TOTO.selects));
			});
		});
		// TO DO: unblock delete button when typed something to field or clear button
	},

	add_uom: function(context) {
		var clone = context.closest('article').clone();
		this.clear_text_fields(clone);
		this.change_ids(clone);
		clone.insertBefore('form > article:last-child');
	},

	remove_uom: function(context) {
		if (this.toggle_remove_button() <= 1) {
			this.clear_all(context.closest('article.uoms'));
		} else {
			context.closest('article').remove();
		}
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
	},

	toggle_remove_button: function(context) {
		var btn = $(document).find('button.remove_uom');
		var num_of_uoms = $(document).find('article.uoms').length
		if (num_of_uoms > 1) {
			btn.removeAttr('disabled');
		} else {
			btn.attr('disabled', 'disabled');
		}
		return num_of_uoms;
	},

	clear_text_fields: function(context) {
		context.find('.uom_val').val('');
		context.find('.uom_multiplier').val('1');
	},

	clear_all: function(context) {
		this.clear_text_fields(context);
	},

	change_ids: function(context) {
		var catch_regex_name_attr = /^([a-z]+\[[a-z_]+\]\[)([0-9]+)(\]\[[a-z_]+\])$/i
		var catch_regex_id_attr = /^([a-z_]+)([0-9]+)([a-z_]+)$/i

		var last_uom_name_attr = $(document).find('article.uoms').last().find('input.uom_val').attr('name');
		var next_id = parseInt(last_uom_name_attr.match(catch_regex_name_attr)[2]) + 1;
		
		context.find('input, select').each(function() {
			var new_name = $(this).attr('name').replace(catch_regex_name_attr, "$1" + next_id + "$3");
			$(this).attr('name', new_name);
			var new_id = $(this).attr('id').replace(catch_regex_id_attr, "$1" + next_id + "$3");
			$(this).attr('id', new_id);
		});

		context.find('label').each(function() {
			var new_id = $(this).attr('for').replace(catch_regex_id_attr, "$1" + next_id + "$3");
			$(this).attr('for', new_id);
		});
	}

}