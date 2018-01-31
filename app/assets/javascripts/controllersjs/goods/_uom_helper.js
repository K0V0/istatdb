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

	decideRemoveButtonActivation: function(uom) {
		if (uom.length > 1) {
			uom.find('button.remove_uom').enable();
		} else {
			uom.find('button.remove_uom').disable();
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

	isValid: function(uom) {
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
	}
}