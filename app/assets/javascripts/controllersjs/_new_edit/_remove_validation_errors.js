function RemoveValidationErrors() {
	this.init();
}

RemoveValidationErrors.prototype = {
	constructor: RemoveValidationErrors,

	init: function() {
		this.onInputRemove();
		this.onActivityRemove();
	},

	onInputRemove: function() {
		// validations associated to input fields values
		$(document)
		.find('input.error, textarea.error')
		.on('input', function() {
			var klass = $(this).attr('class').replace(/^(error)\s+/, "");
			$(this).closest('article').find('span.' + klass).remove();
			$(this).removeClass('error');
		});
	},

	onActivityRemove: function() {
		// validations associated to whole 'window', like when value not entered nor selected
		$(document)
		.find('article')
		.on('change', function() {
			var klass = $(this).data('searcher-assoc') + "_select_error";
			$(this).find('span.'+klass).remove();
		});
	}

}