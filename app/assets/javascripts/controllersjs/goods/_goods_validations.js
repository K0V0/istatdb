
function GoodsValidations() {
	this.init();
}

GoodsValidations.prototype = {
	constructor: GoodsValidations,

	init: function() {
		$(document).find('input.local_taric_kncode').hsCodeFormat();
	}

}
