function CheckExistence() {
	this.init();
}

CheckExistence.prototype = {
	constructor: CheckExistence,

	init: function() {
		var T = this;
		$(document)
		.children('html')
		.children('body')
		.not('.edit, .update')
		.find('input.js_check_existence')
		.frequentFireLimit('input', 350, '', function() {
			T.doAjax($(this));
		});
	},

	doAjax: function(ref) {
		$.ajax({
		  	method: "POST",
		 	url: '/' + ref.data('model') + '/check_existence',
		  	data: {
		  		field: ref.data('field'),
		  		field_id: ref.attr('id'),
		  		text: ref.val(),
		  		window_id: ref.closest('article').attr('id'),
		  		model: ref.data('model')
		  	}
		});
	}

}
