function Uom() {
	this.D = new UomDropdown();
	this.H = new UomHelper();
	this.init();
}

Uom.prototype = {
	constructor: Uom,

	init: function() {
		this.D.rememberDropdownsInitialStates();
		this.D.recollectAvailOptionsForDropdowns();
		this.onChange();
	},

	onChange: function() {
		var T = this;
		$(document)
		.find('article.uoms')
		.find('input, select')
		.on('change', this, function() {
			T.H.decideButtonsActivation($(this).closest('article'));
			//console.log($(this));
			
			//logger($(this).closest('article.uoms'));
		});
	}
}