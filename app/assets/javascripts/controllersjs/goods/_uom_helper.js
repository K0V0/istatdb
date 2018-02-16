function UomHelper() {
	this.AM = new AttrsManipulator();
}

UomHelper.prototype = {
	constructor: UomHelper,

	restore: function(uom) {
		uom.find('input, select').each(function() {
			$(this).val($(this).data('initial'));
		});
		this.decideClearButtonActivation(uom);
	},

	delete: function(uom) {
		if ($('body').is('.edit, .update')) {
			uom.children('input.delete_uom').val('1');
			uom.addClass('to_delete');
		} else {
			uom.remove();
		}
		this.decideRemoveButtonActivation($(document).find('aside').children('article.uoms'));
	},

	cancelDelete: function(uom) {
		uom.children('input.delete_uom').val('false');
		uom.removeClass('to_delete');
	},

	addNext: function(uom) {
		// uom - uom "window" object
		newUom = uom.clone(true, true);
		this.setUpClone(newUom);
		$(document).find('aside').append(newUom);
		this.decideAddButtonActivation(newUom);
		this.decideRemoveButtonActivation($(document).find('aside').children('article.uoms'));
	},

	setUpClone: function(uom) {
		var T = this;
		var next_id = parseInt($(document).find('article.uoms').last().attr('id').match(/^\D+(\d+)$/)[1]) + 1;
		$(uom)
			.attr('id', 'uom_'+next_id);
		$(uom)
			.children('div')
			.children('div')
			.not('div.form_errors')
			.children('label, input, select')
			.each(function() {
				var attr_type = this.hasAttribute('for') ? 'for' : 'name';
				T.AM.generateNewUomInputAttr($(this), attr_type, next_id);
				if (this.hasAttribute('id')) { T.AM.generateNewUomInputAttr($(this), 'id', next_id); }
				if ($(this).hasClass('uom_val')) { $(this).val(''); }
			});
	},

	decideRemoveButtonActivation: function(uoms) {
		var btn = uoms.find('button.remove_uom');
		(uoms.length > 1) ? btn.enable() : btn.disable();
		if ($('body').is('.edit, .update')) { btn.enable(); }
	},

	decideAddButtonActivation: function(uom) {
		var btn = uom.find('button.add_uom');
		this.isValid(uom) ? btn.enable() : btn.disable();
		//console.log("this.isValid(uom)", this.isValid(uom));
	},

	decideClearButtonActivation: function(uom) {
		var btn = uom.find('button.restore_uom');
		this.isDefault(uom) ? btn.disable() : btn.enable();
	},

	isValid: function(uom) {
		// check if ALL are valid
		var valid = {};
		valid['uom_val'] = 				/^[0-9\.\,]+\s*$/.test(uom.find('input.uom_val').first().val());
		valid['uom_multiplier'] = 		/^[0-9]+\s*$/.test(uom.find('input.uom_multiplier').first().val());
		valid['uom_type'] =				uom.find('select.uom_type').val() != '';
		valid['uom_impexpcompany'] = 	uom.find('select.uom_impexpcompany').val() != '';
		valid['uom_manufacturer'] = 	uom.find('select.uom_manufacturer').val() != '';

		// make check for error class on element
		has_any_errorclass = false;
		uom.find('input, select').each(function() {
			if ($(this).hasClass('error')) { has_any_errorclass = true; return false; }
		});
		if (has_any_errorclass) { return false; }

		for (var key in valid) {
		    if (valid[key] === false) {
		    	return false;
		    }
		}
		return true;
	},

	isDefault: function(uom) {
		// check if at least ONE is different from default
		var is_default = true;
		uom.find('input, select').each(function() {
			if ($(this).val() != $(this).data('initial')) {
				is_default = false;
				// false ends only each loop in this case, not returning from whole fx()
				return is_default;
			}
		});
		return is_default;
	}

}
