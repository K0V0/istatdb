function CheckExistence() {
	this.init();
}

CheckExistence.prototype = {
	constructor: CheckExistence,

	init: function() {
		var T = this;
		$(document)
		.find('input.js_check_existence')
		.frequentFireLimit('input', 350, '', function() {
			//logger($(this).val());
			T.doAjax($(this));
		});
	},

	doAjax: function(ref) {
		$.ajax({
		  	method: "POST",
		 	url: '/' + ref.data('model') + '/check_existence',
		  	data: {
		  		field: ref.data('field'),  
		  		text: ref.val()
		  	}
		});
	}

}