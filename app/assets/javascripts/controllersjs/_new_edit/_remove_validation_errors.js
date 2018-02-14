function RemoveValidationErrors() {
	this.H = new RemoveValidationErrorsHelper();
	this.init();
}

RemoveValidationErrors.prototype = {
	constructor: RemoveValidationErrors,

	init: function() {
		this.onActivityRemove();
		this.onInputRemove();
	},

	onInputRemove: function() {
		var H = this.H;
		// validations associated to input fields values
		$(document)
		.find('input.error, textarea.error')
		.on('input', function() { H.removeError(this); });
		//selects
		$(document)
		.find('select.error')
		.on('change', function() { H.removeError(this); logger('kokoooot'); });
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

function RemoveValidationErrorsHelper() {}
RemoveValidationErrorsHelper.prototype = {
	constructor: RemoveValidationErrorsHelper,

	removeError: function(field) {
		var klass = $(field).attr('class').replace(/^(error)\s+/, "");
		$(field).closest('article').find('span.' + klass).remove();
		$(field).removeClass('error');
	}
}