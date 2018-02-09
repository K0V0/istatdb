function RemoveValidationErrors() {
	this.init();
}

RemoveValidationErrors.prototype = {
	constructor: RemoveValidationErrors,

	init: function() {
		this.onInputRemove();
	},

	onInputRemove: function() {
		$(document)
		.find('input.error, textarea.error')
		.on('input', function() {
			var klass = $(this).attr('class').replace(/^(error)\s+/, "");
			$(this).closest('article').find('span.' + klass).remove();
			$(this).removeClass('error');
		});
	}

	/*onSelectRemove: function() {
		$(document)
		.find('input.error, textarea.error')
		.on('input', function() {
			var klass = $(this).attr('class').replace(/^(error)\s+/, "");
			$(this).closest('article').find('span.' + klass).remove();
			$(this).removeClass('error');
		});
	}*/

}