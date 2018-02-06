function UomHelper() {
	this.init();
}

UomHelper.prototype = {
	constructor: UomHelper,

	init: function() {

	},

	onChangeUom: function() {
		// on change any input inside uom
		var T = this;
		$(document)
		.find('article.uoms')
		.find('input, select')
		.on('change', this, function() {
			logger('on change uom runngin');
			T.decideAddButtonActivation($(this).closest('article'));
			T.decideClearButtonActivation($(this).closest('article'));
		});
	},

	onChangeUoms: function() {
		// on change uoms windows count
		var par = $(document).find('aside');
		this.decideRemoveButtonActivation(par.children('article.uoms'));
	},

	setUpClone: function(uom) {
		var next_id = $(document).find('article.uoms').last().attr('id').match(/^\D+(\d)$/)[1] + 1;
		//logger(next_id);
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
		valid['impexpcompany'] = 	uom.find('select.uoms_impexpcompany_select').val() != '';
		valid['manufacturer'] = 	uom.find('select.uoms_manufacturer_select').val() != '';

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
	},

	saveDefaults: function() {
		$(document).find('article.uoms').find('input, select').each(function() {
			$(this).data('initial', $(this).val());
		});
	}

}