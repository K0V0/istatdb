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
		uom.remove();
		this.decideRemoveButtonActivation($(document).find('aside').children('article.uoms'));
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
	},

	decideAddButtonActivation: function(uom) {
		var btn = uom.find('button.add_uom');
		this.isValid(uom) ? btn.enable() : btn.disable();
	},

	decideClearButtonActivation: function(uom) {
		var btn = uom.find('button.restore_uom');
		this.isDefault(uom) ? btn.disable() : btn.enable();
	},

	isValid: function(uom) {
		// check if ALL are valid
		var valid = {};
		valid['num'] = 				/^[0-9\.\,]+\s*$/.test(uom.find('input.uom_val').first().val());
		valid['multiplier'] = 		/^[0-9]+\s*$/.test(uom.find('input.uom_multiplier').first().val());
		valid['unit'] =				uom.find('select.uom_type').val() != '';
		valid['impexpcompany'] = 	uom.find('select.uom_impexpcompany').val() != '';
		valid['manufacturer'] = 	uom.find('select.uom_manufacturer').val() != '';

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
