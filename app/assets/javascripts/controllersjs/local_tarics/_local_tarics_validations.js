function LocalTaricsValidations() {
	this.init();
}

LocalTaricsValidations.prototype = {
	constructor: LocalTaricsValidations,

	init: function() {
		$(document).find('input.kncode_searchfield').hsCodeFormat();
	}

}