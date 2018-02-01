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
			logger('runngin');

			T.decideAddButtonActivation($(this).closest('article'));
			T.decideClearButtonActivation($(this).closest('article'));
			//T.H.decideIf2ndIsResetOrRemove($(this).closest('article'));
			//console.log($(this));
			
			//logger($(this).closest('article.uoms'));
		});
	},

	onChangeUoms: function() {
		// on change uoms windows count
		var par = $(document).find('aside');
		this.decideRemoveButtonActivation(par.children('article.uoms'));
	},

	decideRemoveButtonActivation: function(uoms) {
		if (uoms.length > 1) {
			uoms.find('button.remove_uom').enable();
		} else {
			uoms.find('button.remove_uom').disable();
		}
	},

	decideAddButtonActivation: function(uom) {
		var is_valid = this.isValid(uom);
		if (is_valid === true) {
			uom.find('button.add_uom').removeAttr('disabled');
		} else {
			uom.find('button.add_uom').attr('disabled', 'disabled');
		}
	},

	decideClearButtonActivation: function(uom) {
		if (this.isDefault(uom) === true) {
			uom.find('button.restore_uom').disable();
		} else {
			uom.find('button.restore_uom').enable();
		}
	},

	isValid: function(uom) {
		// check if ALL are valid
		var valid = {};
		//vr is_valid = true;
		//logger($(uom).children('div > div > input.uom_val').first());
		
		valid['num'] = 				/^[0-9\.\,]+\s*$/.test(uom.find('input.uom_val').first().val());
		valid['multiplier'] = 		/^[0-9]+\s*$/.test(uom.find('input.uom_multiplier').first().val());
		valid['unit'] =				uom.find('select.uom_type').val() != '';
		valid['impexpcompany'] = 	uom.find('select.uoms_impexpcompany_select').val() != '';
		valid['manufacturer'] = 	uom.find('select.uoms_manufacturer_select').val() != '';

		for (var key in valid) {
		   // console.log(valid[key]);
		    if (valid[key] === false) {
		    	return false;
		    	//is_valid = false;
		    	//break;
		    }
		}
		return true;
	},

	isDefault: function(uom) {
		// check if at least ONE is different from default
		var is_default = true;
		uom.find('input, select').each(function() {

			if ($(this).val() != $(this).data('initial')) {
				logger('another');
				is_default = false;
				return is_default;
				//break;
			}
		});
		return is_default;
	},

	saveDefaults: function() {
		logger('save detaults running')
		$(document).find('article.uoms').find('input, select').each(function() {
			$(this).data('initial', $(this).val());
		});
	},

	saveStraightUserManipulation: function(input) {
		logger('user_selected');
		//logger(input.val());
		input.data('user_explicitly_selected', input.val());
	}

}