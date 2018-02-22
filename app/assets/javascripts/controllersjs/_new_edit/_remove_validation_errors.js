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
		$(document)
		.find('input.error, textarea.error')
		.closest('div')
		.next()
		.children('input.allow_add_new')
		.on('change', function(e) {
			if (!$(this).is(':checked')) {
				$(this).closest('div').prev().children('input, textarea').removeClass('error');
			}
		});
		//selects
		/*$(document)
		.find('article.uoms')
		.children('div')
		.children('div')
		.on('change', 'select', function() { H.removeError(this); logger('kokoooot'); });*/
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
