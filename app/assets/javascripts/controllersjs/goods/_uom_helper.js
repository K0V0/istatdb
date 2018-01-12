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
		this.isValid(uom);
	},

	isValid: function(uom) {
		var valid = {};
		logger($(uom).children('div > div > input.uom_val').first());
		
		valid['num'] = $(uom).children('div > div > input.uom_val').val().test(/^[0-9\.\,]+\s*$/);
		valid['multiplier'] = $(uom).children('div > div > input.uom_multiplier').val().test(/^[0-9]+\s*$/);
		valid['unit'] = $(uom).children('div > div > div.uom_type > select').val() != '';

		for (var key in valid) {
		    console.log(valid[key]);
		}
		
	}
}