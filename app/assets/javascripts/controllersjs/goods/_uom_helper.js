function UomHelper() {
	this.init();
}

UomHelper.prototype = {
	constructor: UomHelper,

	init: function() {

	},

	decideEnableForAddButton: function(uom) {

	},

	decideButtonsActivation: function(uom) {
		var is_valid = this.isValid(uom);
	},

	isValid: function(uom) {
		var valid = {};
		//vr is_valid = true;
		//logger($(uom).children('div > div > input.uom_val').first());
		
		valid['num'] = 				/^[0-9\.\,]+\s*$/.test(uom.find('input.uom_val').first().val());
		valid['multiplier'] = 		/^[0-9]+\s*$/.test(uom.find('input.uom_multiplier').first().val());
		//valid['unit'] =				uom.find('div.uom_type > select').val() != '';
		//valid['impexpcompany'] = 	uom.find('div.uom_type > select').val() != '';

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