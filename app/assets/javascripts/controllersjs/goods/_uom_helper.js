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
		this.isValid();
	},

	isValid: function(uom) {
		var valid[];
		valid['num'] = $(uom).children('div > div > input.uom_val').val().test(/^[0-9\.\,]+\s*$/);
	}
}