function RemoveValidationErrors() {
	this.init();
}

RemoveValidationErrors.prototype = {
	constructor: RemoveValidationErrors,

	init: function() {

	},

	onInputRemove: function() {
		$(document).find('input.error').on('input', function() {
			var klass = $(this).attr('class').replace(/^(error)\s+/, "");
			
		});
	}

}