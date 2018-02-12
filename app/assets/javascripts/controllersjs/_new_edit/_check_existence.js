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
		// ref - input field that event occurs on
		//var toto = this;
		//var wndw = ref.closest('article');

		$.ajax({
		  	method: 	"POST",
		 	url: 		'/' + wndw.data('searcher-assoc').pluralize() + '/new_select_search',
		  	data: { 
		  		q: 					toto.generateQueryString(wndw),
		  		model: 				wndw.data('searcher-assoc'),
		  		source_controller: 	$('body').data('controller_name').singularize(),
		  		association_type: 	wndw.children('input[name=assoc-type]').val(),
		  		window_id: 			wndw.attr('id')
		  	}
		});
	},
}